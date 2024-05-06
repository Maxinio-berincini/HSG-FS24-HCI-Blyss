import 'package:ar_flutter_plugin_flutterflow/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_node.dart';
import 'package:ar_flutter_plugin_flutterflow/widgets/ar_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../catalog/product.dart';
import '../helper/blyssIcons_icons.dart';
import '../helper/colors.dart';
import '../helper/text_styles.dart';
import '../settings/service_locator.dart';
import '../settings/settings_controller.dart';

class ARModelViewer extends StatefulWidget {
  final Product product;

  const ARModelViewer({Key? key, required this.product}) : super(key: key);
  static const routeName = '/ar-model-viewer';

  @override
  _ARModelViewerState createState() => _ARModelViewerState();
}

class _ARModelViewerState extends State<ARModelViewer> {
  SettingsController? settingsController;
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  bool showPlanes = true;
  bool isLoading = false;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  @override
  void initState() {
    super.initState();
    settingsController = locator<SettingsController>();
    settingsController?.loadSettings().then((_) {
      setState(() {
        showPlanes = settingsController!.planeIndicatorsEnabled;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          if (kIsWeb)
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      BlyssIcons.pc_error,
                      size: 100,
                      color: isDarkMode
                          ? ColorStyle.accentGreyLight
                          : ColorStyle.accentGrey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'AR View is not supported on Web.\nPlease use a mobile device',
                      style: Style().infoFont.copyWith(
                          color: isDarkMode
                              ? ColorStyle.accentGreyLight
                              : ColorStyle.accentGrey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ))
          else
            ARView(
              onARViewCreated: _onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
          Positioned(
            top: 0,
            left: 8,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(BlyssIcons.xmark, size: 16),
                onPressed: () => Navigator.of(context).pop(),
                color: Colors.white,
              ),
            ),
          ),
          if (isLoading)
            Positioned(
              child: Container(
                alignment: Alignment.center,
                color: ColorStyle.black.withOpacity(0.5),
                child: CircularProgressIndicator(color: ColorStyle.white),
              ),
            ),
        ],
      ),
    );
  }

  void _onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: showPlanes,
          customPlaneTexturePath: "Images/triangle.png",
          showAnimatedGuide: true,
          showWorldOrigin: false,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    if (isLoading || nodes.isNotEmpty) {
      // Prevent adding new nodes if one is already loading or placed
      return;
    }

    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);

    if (singleHitTestResult != null && nodes.length < 1) {
      setState(() {
        isLoading = true; // Start loading
      });

      var newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);

      if (didAddAnchor!) {
        this.anchors.add(newAnchor);
        // Add note to anchor
        var newNode = ARNode(
            type: NodeType.localGLTF2,
            uri: widget.product.objPath,
            scale: vector.Vector3(widget.product.objScale,
                widget.product.objScale, widget.product.objScale),
            position: vector.Vector3(0.0, 0.0, 0.0),
            rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0));
        bool? didAddNodeToAnchor = await this
            .arObjectManager!
            .addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          this.nodes.add(newNode);
        } else {
          this.arSessionManager!.onError!("Adding Node to Anchor failed");
        }
      } else {
        this.arSessionManager!.onError!("Adding Anchor failed");
      }
    }
    setState(() {
      isLoading = false; // Stop loading
    });
  }
}

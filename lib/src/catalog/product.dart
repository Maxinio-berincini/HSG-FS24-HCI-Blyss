class Product {
  final int id;
  final String title;
  final String category;
  final String shortDescription;
  final String description;
  final double price;
  final double rating;
  final String imagePath;
  final String objPath;
  final double objScale;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.shortDescription,
    required this.description,
    required this.price,
    required this.rating,
    required this.imagePath,
    required this.objPath,
    required this.objScale,
  });



  static int findProductIndexById(int productId) {
    return products.indexWhere((product) => product.id == productId);
  }

  static Product getProductById(int productId) {
    return products.firstWhere((product) => product.id == productId);
  }
}

final List<Product> products = [
  Product(
    id: 1,
    title: 'Gucci Seal Teddy Bear',
    category: 'Toys / Soft toys',
    shortDescription: 'A luxurious fusion of playfulness and Gucci\'s iconic elegance...',
    description: 'Introducing the exquisite Gucci Seal Teddy Bear - a luxurious blend of whimsy and elegance. This charming collectible is crafted with the finest materials, embodying the sophistication and iconic style synonymous with Gucci. With its plush, velvety fur and endearing features, this teddy bear is more than a toy; it\'s a statement piece and a nod to the playful side of high fashion.',
    price: 420.0,
    rating: 4.5,
    imagePath: 'assets/images/products/gucci_seal_teddy.jpg',
    objPath: 'assets/models/gucci_seal_teddy/gucci_seal_teddy.gltf',
    objScale: 0.5,
  ),

  Product(
    id: 2,
    title: 'Premium Ball Valve',
    category: 'Utilities / Valves',
    shortDescription: 'Experience unparalleled precision with our Premium Ball Valve...',
    description: 'Introducing the Premium Ball Valve, the epitome of industrial excellence and reliability, designed to provide unmatched control and durability. Constructed from the finest materials, this valve is engineered for optimal performance in any setting, offering precise fluid management with a robust design. Its smooth operation and resistance to wear make it a staple in systems requiring accurate flow regulation, ensuring long-term dependability and efficiency. Perfect for professionals and industries seeking the highest standard in valve technology.',
    price: 142.0,
    rating: 2.5,
    imagePath: 'assets/images/products/premium_ball_valve.jpg',
    objPath: 'assets/models/premium_ball_valve/premium_ball_valve.gltf',
    objScale: 0.2,
  ),

  Product(
    id: 3,
    title: 'Deluxe Energy Elixir',
    category: 'Beverages / Energy Drinks',
    shortDescription: 'A revitalizing blend of natural ingredients and electrifying taste...',
    description: 'Elevate your day with the Deluxe Energy Elixir, a premium energy drink crafted for those who seek both superior performance and exhilarating flavors. This energy drink combines a unique blend of natural stimulants, vitamins, and minerals, formulated to boost your stamina and mental clarity. With its vibrant taste and sustained energy release, the Deluxe Energy Elixir is your perfect partner for long days and intense sessions, providing not just an energy boost but also a deliciously refreshing experience.',
    price: 69.0,
    rating: 5,
    imagePath: 'assets/images/products/deluxe_energy_elixir.jpg',
    objPath: 'assets/models/deluxe_energy_elixir/deluxe_energy_elixir.gltf',
    objScale: 0.2,
  ),

  Product(
    id: 4,
    title: 'Supreme Porsche Model',
    category: 'Toys / Models',
    shortDescription: 'A meticulously crafted miniature, celebrating precision engineering...',
    description: 'Experience the thrill of precision engineering with our Supreme Porsche Model, a meticulously crafted replica of the iconic Porsche. This collector’s item is designed with attention to every detail, from the sleek, aerodynamic lines to the intricately detailed interior, replicating the luxury and performance Porsche is known for. Ideal for collectors and automotive enthusiasts, this model not only celebrates the heritage of one of the world’s premier sports cars but also serves as a stunning display piece in any collection.',
    price: 599.0,
    rating: 5,
    imagePath: 'assets/images/products/supreme_porsche_model.jpg',
    objPath: 'assets/models/supreme_porsche_model/scene.gltf',
    objScale: 0.3,
  ),

];

import 'package:flutter/material.dart';
import 'package:softbenzproduct/screens/product_detail_response.dart';
import 'package:softbenzproduct/screens/widgets/image_gallery.dart';
import 'package:softbenzproduct/services/product_detail_service.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Product? product;
  bool isLoading = true;
  bool isContactSeller = false; 
  Map<String, String?> selectedVariants = {};
  VariantDetail? selectedVariantDetail;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    try {
      final fetchedProduct = await ProductDetailService.getProductDetails();
      setState(() {
        product = fetchedProduct;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Error loading product details: $e");
    }
  }

  double calculateDiscountPercent(int price, int strikePrice) {
    return ((strikePrice - price) / strikePrice) * 100;
  }

void _selectVariant(String type, String value) {
  setState(() {
    selectedVariants[type] = value;
    selectedVariantDetail = _getMatchingVariantDetail();
  });
}

  VariantDetail? _getMatchingVariantDetail() {
    for (var variantDetail in product?.variantDetails ?? []) {
      bool matches = true;
      for (var variant in variantDetail.variants ?? []) {
        if (selectedVariants[variant.type] != variant.value) {
          matches = false;
          break;
        }
      }
      if (matches) return variantDetail;
    }
    return null;
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Thank you for contacting us")),
    );
    setState(() {
      isContactSeller = false;
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : product == null
                  ? const Center(child: Text("Failed to load product details"))
                  : _buildProductDetails(),
          if (!isContactSeller)
            _buildContactSellerButton(),
          if (isContactSeller)
            _buildMessageBox(),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageGallery(images: selectedVariantDetail?.image ?? product?.image ?? []),
          const SizedBox(height: 16),
          Text(
            product?.name ?? "Product Name",
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          _buildPriceAndDiscount(),
          const SizedBox(height: 8),
          Text("Category: ${product?.categoryName ?? 'N/A'}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
          const SizedBox(height: 10),
          _buildStockInfo(),
          const SizedBox(height: 16),
          _buildAddToCartButton(),
          const SizedBox(height: 16),
          if (product!.variantDetails != null) buildVariantSection(),
          const SizedBox(height: 16),
          if (product!.specification != null) _buildSpecifications(),
          
          const SizedBox(height: 16),
          _buildReviews(),
        ],
      ),
    );
  }

  Widget _buildPriceAndDiscount() {
  final price = selectedVariantDetail?.price ?? product?.price;
  final strikePrice = selectedVariantDetail?.strikePrice ?? product?.strikePrice;

  return Row(
    children: [
      Text(
        "Rs. ${price?.toStringAsFixed(2) ?? '0.00'}",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
      const SizedBox(width: 8),
      if (strikePrice != null)
        Text(
          "Rs. ${strikePrice.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 18, color: Colors.grey, decoration: TextDecoration.lineThrough),
        ),
      const SizedBox(width: 8),
      if (strikePrice != null)
        Text(
          "-${calculateDiscountPercent(price ?? 0, strikePrice).toStringAsFixed(1)}%",
          style: const TextStyle(fontSize: 16, color: Colors.redAccent),
        ),
    ],
  );
}


Widget _buildStockInfo() {
  final stock = selectedVariantDetail?.stock ?? product?.stock;
  return Text("Stock: ${stock ?? 'N/A'} items available", style: const TextStyle(fontSize: 16, color: Colors.black54));
}

  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Added to cart")));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text("Add to Cart", style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  Widget buildVariantSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: product?.variants?.map((variant) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  variant.type?.name ?? "",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 5,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: variant.values?.map((value) {
                    final isSelected = selectedVariants[variant.type?.name] == value.value;
                    return ChoiceChip(
                      label: Text(
                        value.value ?? "",
                        style: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                      ),
                      selected: isSelected,
                      onSelected: (isSelected) {
                        _selectVariant(variant.type?.name ?? "", value.value ?? "");
                      },
                      backgroundColor: Colors.grey.shade300,
                      selectedColor: Colors.green,
                    );
                  }).toList() ?? [],
                ),
              ),
            ],
          ),
        );
      }).toList() ?? [],
    );
  }

  Widget _buildSpecifications() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Specifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6.0, offset: const Offset(0, 3))],
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product!.specification!.map((spec) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
                      Expanded(child: Text("${spec.type}: ${spec.value}", style: const TextStyle(fontSize: 16, color: Colors.black87))),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    final reviews = [
      {"name": "Naresh Paresh", "rating": 4.5, "comment": "Great product! Very satisfied with the quality."},
      {"name": "Mahilo Kanxo", "rating": 4.0, "comment": "Good value for money. Would recommend to others."},
      {"name": "Jhampe Kanxi", "rating": 5.0, "comment": "Exceeded my expectations! Highly recommend this."},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Customer Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Column(
            children: reviews.map((review) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(review["name"].toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                        Row(
                          children: List.generate(5, (index) {
                            final filled = index < (review["rating"] as double).round();
                            return Icon(filled ? Icons.star : Icons.star_border, color: Colors.amber, size: 20);
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(review["comment"].toString(), style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSellerButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isContactSeller = true;
            });
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text("Contact Seller", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Widget _buildMessageBox() {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: "Type your message here",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _sendMessage,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text("Send", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    ),
  );
}

}

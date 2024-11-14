

import 'dart:convert';

ProductDetailResponse productDetailResponseFromJson(String str) => ProductDetailResponse.fromJson(json.decode(str));

class ProductDetailResponse {
    Product? data;

    ProductDetailResponse({
        this.data,
    });

    factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => ProductDetailResponse(
        data: Product.fromJson(json["data"]),
    );

  
}

class Product {
    String? id;
    String? slug;
    String? name;
    int? price;
    int? strikePrice;
    int? minOrder;
    int? maxOrder;
    bool? variantStatus;
    String? category;
    String? categoryName;
    String? categorySlug;
    bool? status;
    List<DataVariant>? variants;
    dynamic stock;
    dynamic initialStock;
    String? description;
    List<Specification>? specification;
    List<VariantDetail>? variantDetails;
    List<Images>? image;
    VendorDetail? vendorDetail;
    int? viewCount;
    bool? isFavourite;
    bool? commissionStatus;
    String? commissionType;
    String? commissionAmount;
    int? averageRating;
    bool? isApproved;
    bool? isFeatured;
    bool? isPublished;
    dynamic unapprovedMessage;

    Product({
        this.id,
        this.slug,
        this.name,
        this.price,
        this.strikePrice,
        this.minOrder,
        this.maxOrder,
        this.variantStatus,
        this.category,
        this.categoryName,
        this.categorySlug,
        this.status,
        this.variants,
        this.stock,
        this.initialStock,
        this.description,
        this.specification,
        this.variantDetails,
        this.image,
        this.vendorDetail,
        this.viewCount,
        this.isFavourite,
        this.commissionStatus,
        this.commissionType,
        this.commissionAmount,
        this.averageRating,
        this.isApproved,
        this.isFeatured,
        this.isPublished,
        this.unapprovedMessage,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        price: json["price"],
        strikePrice: json["strike_price"],
        minOrder: json["min_order"],
        maxOrder: json["max_order"],
        variantStatus: json["variant_status"],
        category: json["category"],
        categoryName: json["category_name"],
        categorySlug: json["category_slug"],
        status: json["status"],
        variants: List<DataVariant>.from(json["variants"].map((x) => DataVariant.fromJson(x))),
        stock: json["stock"],
        initialStock: json["initial_stock"],
        description: json["description"],
        specification: List<Specification>.from(json["specification"].map((x) => Specification.fromJson(x))),
        variantDetails: List<VariantDetail>.from(json["variant_details"].map((x) => VariantDetail.fromJson(x))),
        image: List<Images>.from(json["image"].map((x) => Images.fromJson(x))),
        vendorDetail: VendorDetail.fromJson(json["vendor_detail"]),
        viewCount: json["view_count"],
        isFavourite: json["is_favourite"],
        commissionStatus: json["commission_status"],
        commissionType: json["commission_type"],
        commissionAmount: json["commission_amount"],
        averageRating: json["average_rating"],
        isApproved: json["is_approved"],
        isFeatured: json["is_featured"],
        isPublished: json["is_published"],
        unapprovedMessage: json["unapproved_message"],
    );

}

class Images {
    String? id;
    dynamic title;
    String? path;

    Images({
        this.id,
        this.title,
        this.path,
    });

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        title: json["title"],
        path: json["path"],
    );

    
}

class Specification {
    String? type;
    String? value;

    Specification({
        this.type,
        this.value,
    });

    factory Specification.fromJson(Map<String, dynamic> json) => Specification(
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
    };
}

class VariantDetail {
    String? id;
    int? price;
    int? strikePrice;
    int? minOrder;
    int? maxOrder;
    bool? status;
    int? stock;
    int? initialStock;
    List<VariantDetailVariant>? variants;
    List<Images>? image;

    VariantDetail({
        this.id,
        this.price,
        this.strikePrice,
        this.minOrder,
        this.maxOrder,
        this.status,
        this.stock,
        this.initialStock,
        this.variants,
        this.image,
    });

    factory VariantDetail.fromJson(Map<String, dynamic> json) => VariantDetail(
        id: json["id"],
        price: json["price"],
        strikePrice: json["strike_price"],
        minOrder: json["min_order"],
        maxOrder: json["max_order"],
        status: json["status"],
        stock: json["stock"],
        initialStock: json["initial_stock"],
        variants: List<VariantDetailVariant>.from(json["variants"].map((x) => VariantDetailVariant.fromJson(x))),
        image: List<Images>.from(json["image"].map((x) => Images.fromJson(x))),
    );
}

class VariantDetailVariant {
    String? id;
    String? type;
    String? value;
    TypeData? typeData;
    Type? valueData;

    VariantDetailVariant({
        this.id,
        this.type,
        this.value,
        this.typeData,
        this.valueData,
    });

    factory VariantDetailVariant.fromJson(Map<String, dynamic> json) => VariantDetailVariant(
        id: json["id"],
        type: json["type"],
        value: json["value"],
        typeData: TypeData.fromJson(json["type_data"]),
        valueData: Type.fromJson(json["value_data"]),
    );

}

class TypeData {
    String? name;

    TypeData({
        this.name,
    });

    factory TypeData.fromJson(Map<String, dynamic> json) => TypeData(
        name: json["name"],
    );

}




class Type {
    String? id;
    String? name;

    Type({
        this.id,
        this.name,
    });

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
    );

   
}

class DataVariant {
    Type? type;
    List<Value>? values;

    DataVariant({
        this.type,
        this.values,
    });

    factory DataVariant.fromJson(Map<String, dynamic> json) => DataVariant(
        type: Type.fromJson(json["type"]),
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
    );

 
}

class Value {
    String? id;
    String? value;

    Value({
        this.id,
        this.value,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
    };
}

class VendorDetail {
    String? id;
    String? user;
    String? slug;
    String? isAdmin;
    String? isVendor;
    String? companyName;
    String? companyAddress;
    String? companyPhone;
    dynamic vatRegisterNo;
    String? businessEmail;
    DateTime ?companyRegistrationDate;
    String? category;
    dynamic subCategory;
    String? description;
    dynamic otherDocument;

    VendorDetail({
        this.id,
        this.user,
        this.slug,
        this.isAdmin,
        this.isVendor,
        this.companyName,
        this.companyAddress,
        this.companyPhone,
        this.vatRegisterNo,
        this.businessEmail,
        this.companyRegistrationDate,
        this.category,
        this.subCategory,
        this.description,
        this.otherDocument,
    });

    factory VendorDetail.fromJson(Map<String, dynamic> json) => VendorDetail(
        id: json["id"],
        user: json["user"],
        slug: json["slug"],
        isAdmin: json["is_admin"],
        isVendor: json["is_vendor"],
        companyName: json["company_name"],
        companyAddress: json["company_address"],
        companyPhone: json["company_phone"],
        vatRegisterNo: json["vat_register_no"],
        businessEmail: json["business_email"],
        companyRegistrationDate: DateTime.parse(json["company_registration_date"]),
        category: json["category"],
        subCategory: json["sub_category"],
        description: json["description"],
        otherDocument: json["other_document"],
    );

   
}

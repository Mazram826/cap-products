namespace com.logali;

type Name : String(50);
type Dec  : Decimal(16, 2);

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
}

entity Products {
    key ID               : UUID;
        Name             : String not null;
        Description      : String;
        ImageURL         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price;
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier         : Association to Suppliers;
        UnitOfMeasure    : Association to UnitOfMeasures;
        Currency         : Association to Currencies;
        DimensionUnit    : Association to DimensionUnits;
        Category         : Association to Categories;
        SalesData        : Association to many SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;
}

entity Suppliers {
    key ID      : UUID;
        Name    : Products:Name;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many Products
                      on Product.Supplier = $self;
}

entity Categories {
    key ID   : String(1);
        Name : type of Products : Name;
}

entity StockAvailability {
    key ID          : Integer;
        Description : String;
}

entity Currencies {
    key ID          : String(3);
        Description : String;
}

entity UnitOfMeasures {
    key ID          : String(2);
        Description : String;
}

entity DimensionUnits {
    key ID          : String(2);
        Description : String;
}

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);
}

entity ProductReview {
    key ID      : UUID;
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to Products;
}

entity SalesData {
    key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to Products;
        Currency      : Association to Currencies;
        DeliveryMonth : Association to Months;
}

entity SelectProducts as select from Products;

entity SelProducts1   as
    select from Products {
        *
    };

entity SelProducts2   as
    select from Products {
        Name,
        Price,
        Quantity
    };

entity SelProducts3   as
    select from Products
    left join ProductReview
        on Products.Name = ProductReview.Name
    {
        Rating,
        Products.Name,
        sum(Price) as TotalPrice
    }
    group by
        Products.Name,
        Rating
    order by
        Rating;

entity ProjProducts   as projection on Products;

entity ProjProducts2  as
    projection on Products {
        *
    }

entity ProjProducts3  as
    projection on Products {
        ReleaseDate,
        Name
    }

extend Products with {
    PriceCondition     : String(2);
    PriceDetermination : String(3);
}

entity Course {
    key ID      : UUID;
        Student : Association to many StudentCourse
                      on Student.Course = $self;
}

entity Student {
    key ID : UUID;
        Course : Association to many StudentCourse
                      on Course.Student = $self;
}

entity StudentCourse {
    key ID      : UUID;
        Student : Association to Student;
        Course  : Association to Course;
}

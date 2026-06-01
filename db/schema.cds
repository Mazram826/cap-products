namespace com.logali;

type name   : String(50);
type Dec    : Decimal(16, 2);

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
}

entity Suppliers {
    key ID      : UUID;
        Name    : Products:Name;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
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
    key Name    : String;
        Rating  : Integer;
        Comment : String;
}

entity SalesData {
    key ID           : UUID;
        DeliveryDate : DateTime;
        Revenue      : Decimal(16, 2);
}

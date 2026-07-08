using {com.logali as logali} from '../db/schema';

service CatalogService {
    entity Products       as projection on logali.Products;
    entity Suppliers      as projection on logali.Suppliers;
    entity Currency       as projection on logali.Currencies;
    entity UnitOfMeasures as projection on logali.UnitOfMeasures;
    entity DimensionUnit  as projection on logali.DimensionUnits;
    entity Category       as projection on logali.Categories;
    entity SalesData      as projection on logali.SalesData;
    entity Reviews        as projection on logali.ProductReview;
}

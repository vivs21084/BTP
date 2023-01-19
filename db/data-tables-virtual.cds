namespace bega.customerportal;

using { cuid } from '@sap/cds/common';
using {  bega.customerportal as db } from './data-model';

context master {

    entity Customer : cuid {
        key PARTNER : String(3);
        key PARTNER_GUID : UUID;
    }

}

context transaction {

    entity ClaimsHeader  {
      key GUID :    UUID; 
      CREATED_AT : DateTime;
      OBJECT_ID : String(10)
    }

     entity Partner   {
      key GUID :  UUID;
      KEY PARTNOR_NO : UUID
    }

    entity Sales  {
      key GUID :  UUID;
      KEY PO_NUMBER_UC : String(35)
    }

    entity Status  {
      key OBJNR :  String(10);
      KEY STAT : String(35)
    }

     entity ClaimsItem  {
      key CLIENT :  String(3);
      key GUID :    UUID; 
      HEADER : UUID;
      PRODUCT : UUID;
    }

    entity ProductItem  {
      key GUID :  String(3);
      PRODUCT_ID :    String(40); 
    }

    entity Product   {
      key PRODUCT_GUID :  String(3);
      GROSS_WEIGHT :    Integer; 
    }
    
    entity Pricing  {
      key PRODUCT_GUID :  String(3);
      GROSS_VALUE:    Decimal; 
    }

}
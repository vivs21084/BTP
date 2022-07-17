namespace vivek.db;

using { cuid, managed, temporal, Currency } from '@sap/cds/common';

using { vivek.common } from './common';

type Guid : String(32);

context master {


entity businesspartner  {
    KEY NODE_KEY: String(32);
    BP_ROLE: String(2);
    EMAIL_ADDRESS: String(64);
    PHONE_NUMBER: String(14);
    FAX_NUMBER : String(14);
    WEB_ADDRESS :String(14);
    ADDRESS_GUID : Association to address;
    BP_ID: String(16);
    COMPANY_NAME: String(80);
}

annotate businesspartner with {
    BP_ROLE @title: '{i18n>bp_role}';
};


entity address  {
    KEY NODE_KEY: String(32);
    CITY: String(120);
    POSTAL_CODE: String(14);
    STREET: String(64);
    BUILDING : String(14);
    COUNTRY :String(14);
    ADDRESS_TYPE: String(2);
    VAL_START_DATE:Date;
    VAL_END_DATE:Date;
    LATITUDE: Decimal;
    LONGITUDE: Decimal;
    businesspartner:  Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
}


  entity product  {
            key NODE_KEY: Guid;
            PRODUCT_ID: String(28);
            TYPE_CODE: String(2);
            CATEGORY: String(32);
            DESCRIPTION: localized String(255);
            SUPPLIER_GUID: Association to master.businesspartner;
            TAX_TARIF_CODE: Integer;
            MEASURE_UNIT: String(2);
            WEIGHT_MEASURE	: Decimal;
            WEIGHT_UNIT: String(2);
            CURRENCY_CODE:String(4);
            PRICE: Decimal(15,2);
            WIDTH:Decimal;	
            DEPTH:Decimal;	
            HEIGHT:	Decimal;
            DIM_UNIT:String(2);
        }

        entity employees: cuid {
            nameFirst: String(40);
            nameMiddle: String(40);	
            nameLast: String(40);	
            nameInitials: String(40);	
            sex	: common.Gender;
            language: String(1);
            phoneNumber: common.PhoneNumber;
            email: common.Email;
            loginName: String(12);
            Currency: Currency;
            salaryAmount: common.AmountT;	
            accountNumber: String(16);	
            bankId: String(20);
            bankName: String(64);
        }
    }

    context transaction {
        
        entity purchaseorder: common.Amount, cuid {
                PO_ID: Integer;     	
                PARTNER_GUID: association to master.businesspartner;                      
                LIFECYCLE_STATUS: String(1);	
                OVERALL_STATUS: String(1);
                Items: Composition of many poitems on Items.PARENT_KEY = $self;
                NOTE: String(256);
                CREATEDBY: UUID;
                MODIFIEDBY : UUID;
                CREATEDAT: Date;
                MODIFIEDAT: Date;
        }

        entity poitems: common.Amount, cuid {
                PARENT_KEY: association to purchaseorder;
                PO_ITEM_POS: Integer;	
                PRODUCT_GUID: association to master.product;           	
                
        }
    }
using { bega.customerportal as db} from '../db/data-model';


service CustomerPortalService {

 @readonly
    view ClaimsHeader as
        select from db.transaction.ClaimsHeader as h
        left join db.transaction.Status as s
            on h.OBJECT_ID = s.OBJNR
        {
            h.OBJECT_ID as ClaimNo,
            h.CREATED_AT   as RaisedOn,
            s.STAT   as Status,
        };
}
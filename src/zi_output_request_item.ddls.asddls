@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Output Request Item - Email'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_OUTPUT_REQUEST_ITEM 
  as select from C_OutputRequestItemDEX
{
  key OutputControlApplicationObject,
      max(OutputRequestItem) as OutputRequestItem
    
}
where
  OutputControlApplObjectType = 'BILLING_DOCUMENT'
  and OutputChannel              = 'EMAIL'
group by OutputControlApplicationObject

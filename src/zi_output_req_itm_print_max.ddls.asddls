@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Output Request Item - Print Max'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_OUTPUT_REQ_ITM_PRINT_MAX
    as select from ZI_OUTPUT_REQUEST_ITEM_PRINT
    left outer join C_OutputRequestItemDEX as _OutputRequestItmDEX on ZI_OUTPUT_REQUEST_ITEM_PRINT.OutputControlApplicationObject = _OutputRequestItmDEX.OutputControlApplicationObject
                                                                      and ZI_OUTPUT_REQUEST_ITEM_PRINT.OutputRequestItem = _OutputRequestItmDEX.OutputRequestItem
{
    key ZI_OUTPUT_REQUEST_ITEM_PRINT.OutputControlApplicationObject,
      ZI_OUTPUT_REQUEST_ITEM_PRINT.OutputRequestItem,
      _OutputRequestItmDEX.OutputRequestItemUUID,
      _OutputRequestItmDEX.OutputControlApplObjectType,     
      _OutputRequestItmDEX.OutputRequestItemStatus,
      _OutputRequestItmDEX.OutputDocumentType,
      _OutputRequestItmDEX.OutputChannel,
      _OutputRequestItmDEX.IsChangeDocument,
      _OutputRequestItmDEX.DispatchTime,
      _OutputRequestItmDEX.CreationDateTime,
      _OutputRequestItmDEX.LastChangeDateTime  
}

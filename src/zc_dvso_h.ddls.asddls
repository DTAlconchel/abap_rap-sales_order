@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: { label: '###GENERATED Core Data Service Entity' }
@ObjectModel: { sapObjectNodeType.name: 'ZDVSO_H' }
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_DVSO_H
  provider contract transactional_query
  as projection on ZR_DVSO_H

  association [1..1] to ZR_DVSO_H as _BaseEntity
    on $projection.SoUUID = _BaseEntity.SoUUID
        
{
  key SoUUID,
      SalesOrder,

      @ObjectModel.text.element: ['SoldToPartyName']
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer', element: 'CustomerID' }, useForValidation: true }]
      SoldToParty,

      @Semantics.text: true
      _Customer.LastName as SoldToPartyName,

      DocumentDate,

      @Consumption: { valueHelpDefinition: [ { entity.element: 'Currency', entity.name: 'I_CurrencyStdVH', useForValidation: true } ] }
      CurrencyCode,

      @Semantics: { amount.currencyCode: 'CurrencyCode' } NetAmount,
      @Semantics: { amount.currencyCode: 'CurrencyCode' } TaxAmount,
      @Semantics: { amount.currencyCode: 'CurrencyCode' } GrossAmount,

      OverallStatus,
      
      // Añadimos los campos del KPI
      @Semantics: { amount.currencyCode: 'CurrencyCode' }
     _KPI.ItemsTotalNetAmount as ItemsTotalNetAmount,
    
     @Semantics: { amount.currencyCode: 'CurrencyCode' }
     _KPI.RemainingAmount as RemainingAmount,
    
     _KPI.ConsumptionCriticality as ConsumptionCriticality,

      @Semantics: { user.createdBy: true } LocalCreatedBy,
      @Semantics: { systemDateTime.createdAt: true } LocalCreatedAt,
      @Semantics: { user.localInstanceLastChangedBy: true } LocalLastChangedBy,
      @Semantics: { systemDateTime.localInstanceLastChangedAt: true } LocalLastChangedAt,
      @Semantics: { systemDateTime.lastChangedAt: true } LastChangedAt,

      _BaseEntity,

      /* Asociaciones */
      _Customer,
      _KPI,
      _Items : redirected to composition child ZC_DVSO_I
}

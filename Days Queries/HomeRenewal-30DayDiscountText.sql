SET NOCOUNT ON

print 'DTR,CustomerId,FirstName,Surname,MobileNumber,OfferProductCode,StartDate,Discount,archive_date'

SELECT 
      [DTR]
      ,[CustomerId]
      ,[FirstName]
      ,[Surname]
      ,[MobileNumber]
      ,[OfferProductCode]
      ,[StartDate]
      ,[Discount]
      ,[archive_date]
  FROM [OP].[CRM].[HomeRenewalReminderDiscountTextsArchive]
  where archive_date = cast(getdate() as date)
		and SendDiscountText = 1
		and DTR = '-30 Days Reminder'

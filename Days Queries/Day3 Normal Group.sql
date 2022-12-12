SELECT [DTR]
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
		and DiscountControlGroup = 1
		and DTR = '-3 Days Reminder'

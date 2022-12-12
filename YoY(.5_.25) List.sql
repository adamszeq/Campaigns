SELECT 
    distinct [OfferProductCode]
    ,[StartDate]
    ,[CustomerId]
    ,[LYTotalAmount]
    ,TotalAmountTY
    ,[FirstName]
    ,[Surname]
	,case when MobilePhoneNumber is not null and MobilePhoneNumber <> '' then MobilePhoneNumber when WorkPhoneNumber is not null and WorkPhoneNumber<> '' then WorkPhoneNumber when HomePhoneNumber is not null and HomePhoneNumber <> '' then HomePhoneNumber else NULL end as MobilePhoneNumber
    ,[OfferTotalAmount]
    ,[OfferInsurerName]
    -- ,case when (TotalAmountTY + isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) > 150 then '150'
	--   when (TotalAmountTY + isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) < 0 then '0'
	--   else cast(floor((TotalAmountTY + isnull(TotalYOYDiscount,0)) - (LYTotalAmount * 1.50)) as varchar) end as Discount
    -- ,(TotalAmountTY+ isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) as DiffMaxAndOffered
    ,[YoYreal]
    -- ,[ContactMethod]
    -- ,[CanBeContacted]
    -- ,[Product]
  FROM [OP].[OP].[RenewalHomeMonitor] ren


-- where StartDate > CAST( GETDATE() AS Date )
--startdate is between today and Jan 15th 2023
where StartDate between CAST( GETDATE() AS Date ) and CAST('2023-01-15' AS Date)
and IsMonthClosedOffRenewal = 0
and IsCancelled =0
and IsLapsed =0
and IsOffered = 1
-- and StartDate > CAST( GETDATE() AS Date ) -- greater than today
and YOYreal > 0.50
-- and YOYreal between 0.25 and 0.5
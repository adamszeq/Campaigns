SELECT 
    distinct ren.OfferProductCode as ProductCode
    -- ,[StartDate] as RenewalDate
    ,ren.StartDate as RenewalDate
    -- ,[FirstName] as FirstName
    ,ren.FirstName as FirstName
    -- ,[Surname] as Surname
    ,ren.Surname as Surname
    -- ,[CustomerId]
    -- ,[LYTotalAmount]
    -- ,TotalAmountTY
    -- ,[MobilePhoneNumber] as MobilePhoneNumber
    ,ren.MobilePhoneNumber as MobilePhoneNumber
    -- ,[HomePhoneNumber] as HomePhoneNumber
    ,ren.HomePhoneNumber as HomePhoneNumber
    -- ,[WorkPhoneNumber] as WorkPhoneNumber
    ,ren.WorkPhoneNumber as WorkPhoneNumber
    -- ,cd.Clean_Phone as 'MobilePhoneNumber2'

	-- ,case when MobilePhoneNumber is not null and MobilePhoneNumber <> '' then MobilePhoneNumber when WorkPhoneNumber is not null and WorkPhoneNumber<> '' then WorkPhoneNumber when HomePhoneNumber is not null and HomePhoneNumber <> '' then HomePhoneNumber else NULL end as MobilePhoneNumber
    -- ,[OfferTotalAmount]
    -- ,[OfferInsurerName]
    -- ,case when (TotalAmountTY + isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) > 150 then '150'
	--   when (TotalAmountTY + isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) < 0 then '0'
	--   else cast(floor((TotalAmountTY + isnull(TotalYOYDiscount,0)) - (LYTotalAmount * 1.50)) as varchar) end as Discount
    -- ,(TotalAmountTY+ isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) as DiffMaxAndOffered
    -- ,[YoYreal] as YoY
    ,ren.YOYreal as YoY 
    -- get YoY as percentage value
    -- ,case when substring(cd.Clean_Phone, 2, 11)  <> substring(ren.MobilePhoneNumber, 6, 14) then 1 else 0 end as Differences
    -- ,case when substring(cd.Clean_Phone, 2, 11)  <> substring(ren.MobilePhoneNumber, 6, 14) and len(cd.Clean_Phone) = 10 then cd.Clean_Phone else 
    -- when substring(cd.Clean_Phone, 2, 11)  is not equal to  substring(ren.MobilePhoneNumber, 6, 14) and length of cd.Clean_Phone = 10 then cd.clean_phone else ren.MobilePhoneNumber end as MobilePhoneNumber3  
    -- , ren.TotalAmountTY
    -- ,ren.OfferIPP
    -- ,'75' as Discount

  

    -- ,[ContactMethod]
    -- ,[CanBeContacted]
    -- ,[Product]
  FROM [OP].[OP].[RenewalHomeMonitor] ren
--   left join op.op.User_Clean_Phone cd on ren.CustomerId=cd.CustomerId


-- where StartDate > CAST( GETDATE() AS Date )
--startdate is between today and Jan 15th 2023
where StartDate between CAST( GETDATE() AS Date ) and CAST('2023-02-28' AS Date)
and IsMonthClosedOffRenewal = 0
and IsCancelled =0
and IsLapsed =0
and IsOffered = 1
-- and cd.Clean_Phone<> ''
-- and StartDate > CAST( GETDATE() AS Date ) -- greater than today
and YOYreal >= 0.50
-- and YOYreal between 0.25 and 0.5

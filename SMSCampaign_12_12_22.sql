IF OBJECT_ID('tempdb..#RenewalSMSCampaign') IS NOT NULL
DROP TABLE #RenewalSMSCampaign

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
    into #RenewalSMSCampaign
  FROM [OP].[OP].[RenewalHomeMonitor] ren


where StartDate > CAST( GETDATE() AS Date )
and IsMonthClosedOffRenewal = 0
and IsCancelled =0
and IsLapsed =0
and StartDate > CAST( GETDATE() AS Date ) -- greater than today
and YOYreal > 0.50
and CanBeContacted = 1

--'#RenewalSMSCampaignReminder'
--archive
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays


SELECT
    OfferProductCode
    ,cast(getdate() as date) as archiveDate
     ,case when rand(cast(HashBytes('MD5', OfferProductCode) as int)) > 0.5 then 'Group A' else 'Group B' end as Groups
    ,DATEDIFF(day, GETDATE(), StartDate) - DATEDIFF(week, GETDATE(), StartDate) * 2 - CASE WHEN DATEPART(dw, GETDATE()) = 1 THEN 1 ELSE 0 END - CASE WHEN DATEPART(dw, StartDate) = 7 THEN 1 ELSE 0 END as WorkingDays
    ,DATEDIFF(day, GETDATE(), StartDate) as DaysToRenewal
    ,StartDate
    ,CustomerId
    ,LYTotalAmount
    ,TotalAmountTY
    ,FirstName
    ,Surname
    -- ,HomePhoneNumber
    -- ,WorkPhoneNumber
    ,MobilePhoneNumber
    -- ,case when MobilePhoneNumber is null then case when HomePhoneNumber is null then WorkPhoneNumber else HomePhoneNumber end else MobilePhoneNumber end as MobilePhoneNumber

    ,OfferTotalAmount
    ,OfferInsurerName
    -- ,Discount
    -- ,DiffMaxAndOffered
    -- ,YoYreal
   

into #RenewalSMSCampaignReminderDays
FROM #RenewalSMSCampaign

-----------------------------------------------------------------------------------------------------
-- Day 3
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays3') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays3

SELECT
    
    '-3 Days Reminder' as DTR
    ,customerid as CustomerId
    ,FirstName as FirstName
    ,Surname as Surname
    ,MobilePhoneNumber as MobileNumber
    ,OfferProductCode as OfferProductCode
    ,StartDate as StartDate
    ,null as 'Discount'
    ,archiveDate as archive_date
    ,case when Groups = 'Group A' then 1 else 0 end as SendDiscountText
    ,null as SendMembershipText
    ,case when Groups = 'Group B' then 1 else 0 end as DiscountControlGroup
    ,null as MembershipControlGroup
    ,null as NoText

into #RenewalSMSCampaignReminderDays3
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 3

--Day 8
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays8') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays8

SELECT
    '-8 Days Reminder' as DTR
    ,customerid as CustomerId
    ,FirstName as FirstName
    ,Surname as Surname
    ,MobilePhoneNumber as MobileNumber
    ,OfferProductCode as OfferProductCode
    ,StartDate as StartDate
    ,null as 'Discount'
    ,archiveDate as archive_date
    ,case when Groups = 'Group A' then 1 else 0 end as SendDiscountText
    ,null as SendMembershipText
    ,case when Groups = 'Group B' then 1 else 0 end as DiscountControlGroup
    ,null as MembershipControlGroup
    ,null as NoText

into #RenewalSMSCampaignReminderDays8
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 8



-- --Day 15
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays15') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays15

SELECT
    '-15 Days Reminder' as DTR
    ,customerid as CustomerId
    ,FirstName as FirstName
    ,Surname as Surname
    ,MobilePhoneNumber as MobileNumber
    ,OfferProductCode as OfferProductCode
    ,StartDate as StartDate
    ,null as 'Discount'
    ,archiveDate as archive_date
    ,case when Groups = 'Group A' then 1 else 0 end as SendDiscountText
    ,null as SendMembershipText
    ,case when Groups = 'Group B' then 1 else 0 end as DiscountControlGroup
    ,null as MembershipControlGroup
    ,null as NoText

into #RenewalSMSCampaignReminderDays15
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 15


-- --Day 25
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays25') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays25

SELECT
    '-25 Days Reminder' as DTR
    ,customerid as CustomerId
    ,FirstName as FirstName
    ,Surname as Surname
    ,MobilePhoneNumber as MobileNumber
    ,OfferProductCode as OfferProductCode
    ,StartDate as StartDate
    ,null as 'Discount'
    ,archiveDate as archive_date
    ,case when Groups = 'Group A' then 1 else 0 end as SendDiscountText
    ,null as SendMembershipText
    ,case when Groups = 'Group B' then 1 else 0 end as DiscountControlGroup
    ,null as MembershipControlGroup
    ,null as NoText

into #RenewalSMSCampaignReminderDays25
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 25

-- SELECT * FROM #RenewalSMSCampaignReminderDays8
-- where 


----------------------------------------------------------------------------------------
delete 
from [OP].[CRM].[HomeRenewalReminderDiscountTextsArchive]
where archive_date = cast(getdate() as date);


insert into [OP].[CRM].[HomeRenewalReminderDiscountTextsArchive]

SELECT * FROM #RenewalSMSCampaignReminderDays3

UNION 
SELECT * FROM #RenewalSMSCampaignReminderDays8

UNION 
SELECT * FROM #RenewalSMSCampaignReminderDays15

UNION 
SELECT * FROM #RenewalSMSCampaignReminderDays25

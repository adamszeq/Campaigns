IF OBJECT_ID('tempdb..#RenewalSMSCampaign') IS NOT NULL
DROP TABLE #RenewalSMSCampaign

SELECT 
    distinct [OfferProductCode]
    ,[StartDate]
    ,cd.[CustomerId]
    -- ,[LYTotalAmount]
    -- ,TotalAmountTY
    ,cd.[FirstName]
    ,cd.[Surname]
	,cd.Clean_Phone as 'MobilePhoneNumber'
    ,[OfferInsurerName]
    ,[YoYreal]
  into #RenewalSMSCampaign
  FROM [OP].[OP].[RenewalHomeMonitor] ren
  left join op.op.User_Clean_Phone cd on ren.CustomerId=cd.CustomerId
where StartDate > CAST( GETDATE() AS Date )
and IsOffered = 1 -----------------------------------------
and IsMonthClosedOffRenewal = 0
and IsCancelled = 0
and IsLapsed = 0
-- and StartDate > CAST( GETDATE() AS Date ) -- greater than today
and YOYreal > 0.15 -----------------------------------------
and CanBeContacted = 1
and cd.Clean_Phone<> ''



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
    -- ,LYTotalAmount
    -- ,TotalAmountTY
    ,FirstName
    ,Surname
    -- ,HomePhoneNumber
    -- ,WorkPhoneNumber
    ,MobilePhoneNumber
    -- ,case when MobilePhoneNumber is null then case when HomePhoneNumber is null then WorkPhoneNumber else HomePhoneNumber end else MobilePhoneNumber end as MobilePhoneNumber

    -- ,OfferTotalAmount
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

-- Day 4
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays4') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays4

SELECT
    '-4 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays4
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 4

-- --Day 5
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays5') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays5

SELECT
    '-5 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays5
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 5

--Day 6
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays6') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays6

SELECT
    '-6 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays6
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 6

-- --Day 7
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays7') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays7

SELECT
    '-7 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays7
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 7

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

-- Day 16
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays16') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays16

SELECT
    '-16 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays16
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 16

-- --Day 17
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays17') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays17

SELECT
    '-17 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays17
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 17

-- --Day 18
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays18') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays18

SELECT
    '-18 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays18
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 18

-- --Day 19
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays19') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays19

SELECT
    '-19 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays19
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 19

-- --Day 20
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays20') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays20

SELECT
    '-20 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays20
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 20

--Day 21
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays21') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays21

SELECT
    '-21 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays21
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 21

-- --Day 22
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays22') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays22

SELECT
    '-22 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays22
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 22

--Day 23
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays23') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays23

SELECT
    '-23 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays23
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 23

-- --Day 24
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays24') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays24

SELECT
    '-24 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays24
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 24

--Day 25
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

--Day 26
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays26') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays26

SELECT
    '-26 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays26
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 26

--Day 27
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays27') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays27

SELECT
    '-27 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays27
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 27

--Day 28
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays28') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays28

SELECT
    '-28 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays28
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 28

--Day 29
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays29') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays29

SELECT
    '-29 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays29
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 29

--Day 30
IF OBJECT_ID('tempdb..#RenewalSMSCampaignReminderDays30') IS NOT NULL
DROP TABLE #RenewalSMSCampaignReminderDays30

SELECT
    '-30 Days Reminder' as DTR
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

into #RenewalSMSCampaignReminderDays30
FROM #RenewalSMSCampaignReminderDays
where DaysToRenewal = 30


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
SELECT * FROM #RenewalSMSCampaignReminderDays16

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays17

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays18

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays19

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays20

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays21

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays22

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays23

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays24

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays25

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays26

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays27

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays28

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays29

UNION
SELECT * FROM #RenewalSMSCampaignReminderDays30


-- SELECT * FROM [OP].[CRM].[HomeRenewalReminderDiscountTextsArchive] where archive_date = cast(getdate() as date)
-- order by DTR

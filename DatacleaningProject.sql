SELECT *
FROM Project.dbo.HouseData$

SELECT SaleDate, Cast(SaleDate as date)
FROM Project.dbo.HouseData$

UPDATE HouseData$
SET SaleDate=Cast(SaleDate as date)

ALTER TABLE HouseData$
Add SaleDateConcerted date;

UPDATE HouseData$
SET SaleDateConcerted=SaleDate

SELECT SaleDateConcerted
FROM Project.dbo.HouseData$

SELECT a.ParcelID,a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Project.dbo.HouseData$ a
join Project.dbo.HouseData$ b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress is null


UPDATE a
Set PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Project.dbo.HouseData$ a
join Project.dbo.HouseData$ b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress is null

Select PropertyAddress
FROM Project.dbo.HouseData$

substring

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
--CHARINDEX(',', PropertyAddress)
--CHARINDEX(',', PropertyAddress)
FROM Project.dbo.HouseData$


ALTER TABLE HouseData$
Add PropertySplitAddress Nvarchar(255);

UPDATE HouseData$
SET PropertySplitAddress=SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE HouseData$
Add PropertySplitCity nvarchar(255);

UPDATE HouseData$
SET PropertySplitCity=SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
FROM Project.dbo.HouseData$

ALTER TABLE HouseData$
Add OwnerSplitAddress nvarchar(255);

UPDATE HouseData$
SET OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

ALTER TABLE HouseData$
Add OwnerSplitCity nvarchar(255);

UPDATE HouseData$
SET OwnerSplitcity=PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

ALTER TABLE HouseData$
Add OwnerSplitState nvarchar(255);

UPDATE HouseData$
SET OwnerSplitState=PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

SELECT *
FROM Project.DBO.HouseData$


SELECT Distinct(SoldAsVacant), Count(SoldAsVacant)
FROM Project.DBO.HouseData$
Group by SoldAsVacant
Order by 1

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant='Y' then 'Yes'
	when SoldAsVacant='N' then 'No'
	else SoldAsVacant
	End
FROM Project.DBO.HouseData$

UPDATE HouseData$
SET SoldAsVacant=CASE WHEN SoldAsVacant='Y' then 'Yes'
	when SoldAsVacant='N' then 'No'
	else SoldAsVacant
	End


WITH ROWNUMCTE AS
(
SELECT *
,   ROW_NUMBER() OVER(
   PARTITION BY ParcelID,
                PropertyAddress,
				SaleDate,
				SalePrice,
				LegalReference
				Order by
				UniqueID
				) row_num
FROM Project.dbo.HouseData$
--ORDER BY ParcelId
)
Select *
FROM ROWNUMCTE
WHERE row_num>1
--order by PropertyAddress

SELECT *
FROM Project.dbo.HouseData$

ALTER TABLE Project.dbo.HouseData$
DROP COLUMN SaleDate,TaxDistrict, OwnerAddress, PropertyAddress


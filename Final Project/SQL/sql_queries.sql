-- Creating DB schema so that I can import from my jupyter notebooks
CREATE DATABASE Final_Project;
use Final_Project;

-- Modifying some columns type for setting up keys
ALTER TABLE colors_mapping MODIFY Hex VARCHAR(50);
ALTER TABLE api_data MODIFY `Avg Color` VARCHAR(50);

-- Setting Primary & Foreign Keys (FK are in the main table and are joined to smaller/mapping tables PK)
ALTER TABLE colors_mapping ADD PRIMARY KEY (Hex),
ALTER TABLE api_data ADD FOREIGN KEY (`Avg Color`) REFERENCES colors_mapping(Hex);

ALTER TABLE countries_mapping ADD PRIMARY KEY (Country_id);
ALTER TABLE api_data ADD FOREIGN KEY (Country_id) REFERENCES countries_mapping(Country_id);

ALTER TABLE photographers_mapping ADD PRIMARY KEY (Photographer_id);
ALTER TABLE api_data ADD FOREIGN KEY (Photographer_id) REFERENCES photographers_mapping(Photographer_id);

ALTER TABLE api_data ADD PRIMARY KEY (Pictures_id);

-- Now let's do the queries !

-- Query 1 : Who are the top contributors in terms of pictures ?

SELECT
b.Photographer_id,
b.Photographer,
COUNT(a.Pictures_id) AS pictures_count
FROM api_data a 
JOIN photographers_mapping b ON a.Photographer_id = b.Photographer_id
GROUP BY
b.Photographer_id,
b.Photographer
ORDER BY pictures_count DESC
LIMIT 10
;

-- Query 2 : What are the average dimension of pictures published by region in the world ?

SELECT
b.region,
AVG(a.Width) AS average_width,
AVG(a.Height) AS average_height
FROM api_data a 
JOIN countries_mapping b ON a.Country_id = b.Country_id
GROUP BY b.region
;

 -- Query 3 : From previous, in avg, pictures look really "big", let's deep dive a bit using CASE WHEN 
 
 WITH subquery AS(
 SELECT 
	Pictures_id,
	CASE WHEN Width <= 500 AND Height <= 500 THEN 'small'
		 WHEN (Width >= 500 AND Width <= 1200) AND (Height >= 500 AND Height <= 1200) THEN 'medium'
         WHEN (Width > 1200) AND (Height >= 1200) THEN 'large'
	     ELSE 'unclassified'
	END AS picture_category
 FROM api_data
 )
SELECT
b.picture_category,
COUNT(a.Pictures_id)
FROM api_data a JOIN subquery b ON a.Pictures_id = b.Pictures_id
GROUP BY 
b.picture_category

-- Query 4: Pretty obvious, let's see if we have landscape images ?
 WITH subquery AS(
 SELECT 
	Pictures_id,
	CASE WHEN Width / Height >= 1.5 THEN 'landscape'
	     ELSE 'not_landscape'
	END AS picture_category
 FROM api_data
 )
SELECT
b.picture_category,
COUNT(a.Pictures_id)
FROM api_data a JOIN subquery b ON a.Pictures_id = b.Pictures_id
GROUP BY 
b.picture_category

-- Query 5: RGB 
SELECT
c.region,
ROUND(AVG(b.R),0) AS avg_red,
AVG(b.G) AS avg_green,
AVG(b.B) AS avg_blue
FROM api_data a 
JOIN colors_mapping b ON a.`Avg Color` = b.Hex
JOIN countries_mapping c ON a.Country_id = c.Country_id
GROUP BY 
c.region


-- Create Campaigns table
CREATE TABLE Campaigns (
    CampaignID INT AUTO_INCREMENT PRIMARY KEY,
    CampaignName VARCHAR(100) NOT NULL,
    CampaignType VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Budget DECIMAL(10, 2) NOT NULL,
    ResponsibleEmployeeID INT,
    FOREIGN KEY (ResponsibleEmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create Campaign_Performance table
CREATE TABLE Campaign_Performance (
    PerformanceID INT AUTO_INCREMENT PRIMARY KEY,
    CampaignID INT NOT NULL,
    SalesGenerated DECIMAL(10, 2),
    Reach INT,
    AverageFeedbackRating DECIMAL(3, 2),
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID)
);

-- Create Campaign_Targets table
CREATE TABLE Campaign_Targets (
    TargetID INT AUTO_INCREMENT PRIMARY KEY,
    CampaignID INT NOT NULL,
    TargetGroup VARCHAR(100) NOT NULL,
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID)
);

-- Insert sample data into Campaigns
INSERT INTO Campaigns (CampaignName, CampaignType, StartDate, EndDate, Budget, ResponsibleEmployeeID) VALUES
('Summer Sale', 'Seasonal Promotion', '2025-02-01', '2025-02-28', 5000.00, 2),
('Black Friday', 'Flash Sale', '2025-11-25', '2025-11-29', 10000.00, 3);

-- Insert sample data into Campaign_Performance
INSERT INTO Campaign_Performance (CampaignID, SalesGenerated, Reach, AverageFeedbackRating) VALUES
(1, 15000.00, 2000, 4.5),
(2, 50000.00, 10000, 4.7);

-- Insert sample data into Campaign_Targets
INSERT INTO Campaign_Targets (CampaignID, TargetGroup) VALUES
(1, 'Customers aged 20-40 in urban areas'),
(2, 'All customers interested in electronics');

-- Query to list all campaigns with details
SELECT 
    Campaigns.CampaignID,
    Campaigns.CampaignName,
    Campaigns.CampaignType,
    Campaigns.StartDate,
    Campaigns.EndDate,
    Campaigns.Budget,
    Employees.EmployeeName AS ResponsibleEmployee
FROM Campaigns
LEFT JOIN Employees ON Campaigns.ResponsibleEmployeeID = Employees.EmployeeID;

-- Query to analyze campaign performance
SELECT 
    Campaigns.CampaignName,
    Campaign_Performance.SalesGenerated,
    Campaign_Performance.Reach,
    Campaign_Performance.AverageFeedbackRating
FROM Campaign_Performance
JOIN Campaigns ON Campaign_Performance.CampaignID = Campaigns.CampaignID;

-- Query to find the most successful campaign
SELECT 
    Campaigns.CampaignName,
    Campaign_Performance.SalesGenerated,
    Campaign_Performance.Reach
FROM Campaign_Performance
JOIN Campaigns ON Campaign_Performance.CampaignID = Campaigns.CampaignID
ORDER BY Campaign_Performance.SalesGenerated DESC
LIMIT 1;

-- Query to count campaigns targeting specific groups
SELECT 
    Campaign_Targets.TargetGroup,
    COUNT(Campaign_Targets.CampaignID) AS NumberOfCampaigns
FROM Campaign_Targets
GROUP BY Campaign_Targets.TargetGroup;

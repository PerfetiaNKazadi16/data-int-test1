create database DEBATES

create table Faculty(
FacultyID varchar(30)
constraint PK_Faculty_FacultyID primary key (FacultyID),
FacultyName varchar(50)
);
create table Venue(
VenueID varchar(30)
constraint PK_Venue_VenueID primary key (VenueID),
VenueName varchar(50),
VenueAddress varchar(50)
);
create table Debate(
DebateID varchar(30)
constraint PK_Debate_DebateID primary key (DebateID),
FacultyID varchar(30)
constraint FK_Faculty_FacultyID foreign key (FacultyID) references Faculty(FacultyID),
FacultyID_B varchar(30),
VenueID varchar(30)
constraint FK_Venue_VenueID foreign key (VenueID) references Venue(VenueID),
DebateDate int,
DebateTime varchar(30),
DebateDuration_MINUTES int
);
select*from Faculty;
select*from Venue;
select*from Debate;

insert into Faculty(FacultyID, FacultyName)values 
('F001','Faculty of science'),
('F002','Faculty of Engineering'),
('F003','Faculty of Humanities'),
('F004','Faculty of law'),
('F005','Faculty of Commerce');
insert into Venue(VenueID,VenueName,VenueAddress)values
('V001','Newton Hall','12 University Road, CapeTown'),
('V002','Curie Centre','44 innovation Avenue, Gqeberha'),
('V003','Plato Auditorium','88 Knowledge Street, Durban'),
('V004','Darwin Hall','15 Research Lane, Johannesburg'),
('V005','Aristotle theatre','9 academic crescent, Tshwane');
insert into Debate(DebateID,FacultyID,FacultyID_B,VenueID,DebateDate,DebateTime,DebateDuration_MINUTES)values
('D001','F001','F002','V001',10/8/2026,'10h00',60),
('D002','F003','F005','V004',11/8/2026,'14h00',90),
('D003','F002','F003','V005',12/8/2026,'18H00',90),
('D004','F001','F005','V003',13/8/2026,'16H00',120),
('D005','F002','F005','V001',14/8/2026,'17H00',120);

alter table Debate
add tickets_available int;

update Debate 
set tickets_available=400 where DebateID='D003';

SELECT v.VenueName
FROM Venue AS v
LEFT JOIN Debate AS d
    ON d.VenueID = v.VenueID
WHERE d.VenueID IS NULL;

SELECT v.VenueName,
       SUM(d.DebateDuration_MINUTES) AS TOTAL_DURATION_MINUTES
FROM Venue v
LEFT JOIN Debate d ON v.VenueID = d.VenueID
GROUP BY v.VenueName
ORDER BY v.VenueName, TOTAL_DURATION_MINUTES ASC;

SELECT TOP (1)
       v.VenueName AS VENUE_NAME,
       d.DebateTime AS DEBATE_TIME,
       d.DebateDuration_MINUTES AS DEBATE_DURATION_MINUTES
FROM Debate AS d
JOIN Venue AS v
    ON v.VenueID = d.VenueID
WHERE d.VenueID = 'V001'
ORDER BY d.DebateDuration_MINUTES DESC;
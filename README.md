# MIST 4610 Group 6: Peach State Film Festival

# Problem Description
The goal of this project is to build a relational database that handles the logistics for the Peach State Film Festival (PSFF), a week-long event hosted at various theaters across Atlanta. Running a festival involves balancing several moving parts: managing film submissions from global creators, scheduling screenings in specific theater rooms, and organizing a large team of volunteers. Our database is designed to keep these operations organized by tracking submission fees, film pairings, ticket reservations, and volunteer shifts. In addition to the case, our model accounts for the additional data tracking which vendors are selling food at which venues and managing the awards given to standout films. By centralizing this data, PSFF can better understand its venue traffic, theater capacity, and overall event success.

# Team Members:
Meghan Thota: Group Leader
Ori Cohen-Aka : SQL Writer
Luke Van Putten: Data Wrangler/Database Designer
Rahul Pullolickal: Conceptual Modeler

# Data Model
Our model is built to show the real-world workflow of a film festival. The Film entity is the center of the system, storing details like language, origin, and rating. Each film is tied to a Category (ex: "documentary") which determines its submission fee and max runtime. We also included a self-referencing relationship in the Film table to handle "paired features," which allows the festival to link two films together for a special double-feature screening.

To keep track of the film's crew, every film is linked to both a Primary Director and an Assistant Director. Our setup allows for flexibility, meaning a director can be the lead on one film but act as an assistant on another. This operates within the Primary Director entity and is made possible by the entitiy's one to many relationship with Film.

The physical side of the festival is managed through Venues and Screening Rooms. Since a single venue has several rooms, we’ve tracked specific details for each, such as ADA accessibility and seating capacity. These rooms host the Screenings. When a Customer wants to see a movie, the Reservation/Tickets table acts as the link, tracking how many seats were booked and whether the person actually checked in at the door.

Staffing is handled through Shifts and Assignments. Volunteers sign up for specific time slots at various venues, and our model ensures that no one is double-booked. The Assignment table works as a bridge to show which volunteers worked which shifts and whether they’ve completed their required training.

In addition to the case provided, we added two key features to the festival's tracking database: 

Vendors & Menu Items: We wanted to track the food and drink side of the event. Vendors are assigned to specific Venues, and their Menu Items are tracked through Transaction Line Items allowing us to see exactly how many of each menu item were purchased in each transcation. Additonally, concession transaction allow for us to see total spent at different vendors, at specific venues, and at each time of day. This allows the festival to see which snacks are selling best at different locations.

Awards: To handle the competitive side of PSFF, the Award table links directly to Films, recording the award's prize and the specific film title of the award won.

This structure ensures that PSFF can manage the "big picture" of the festival while still keeping track of the small details like volunteer training and food sales. This model accounts for various aspects that are needed to make the event run smoothly and has the potential to be useful in planning more efficient future festival through data analysis.

<img width="716" height="469" alt="Screenshot 2026-04-09 at 11 41 03 AM" src="https://github.com/user-attachments/assets/18b2574c-d7c0-4097-a33e-b047011318b6" />

# Data Dictionary
# MIST 4610 – Data Dictionary

---

## 1. Assignment

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| assignment.shift.id | References the scheduled shift time block. | INT | 11 | N/A | PK, FK → Shift.shift.id |
| assignment.staff.id | References the assigned worker. | INT | 11 | N/A | PK, FK → Staff/Voulenteer.staff.id |
| assignment.ven.id | References the venue where the shift takes place. | INT | 11 | N/A | FK → Shift.Venue_ven.id |
| Assignment.checkin | Indicates if the worker clocked in for their shift. | VARCHAR | 45 | Yes|No | |

---

## 2. Award

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| Award.id | Unique identifier for the festival award. | INT | 11 | N/A | PK |
| award.name | The title of the award (e.g., Best Picture). | VARCHAR | 45 | N/A | |
| award.prize | The cash prize dollar amount associated with winning. | DECIMAL | 2 | Max 99 | |
| Film_f.id | References the winning movie. | INT | 11 | N/A | FK → Film.f.id |

---

## 3. Category

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| cat.code | Unique identifier for the film category. | INT | 11 | N/A | PK |
| cat.name | The descriptive name of the category. | VARCHAR | 45 | N/A | |
| cat.max_runtime | The maximum allowed runtime for films in this category. | TIME | N/A | HH:MM:SS | |
| cat.subfee | The dollar amount required to submit a film to this category. | DECIMAL | 5,2 | N/A | |

---

## 4. Consession Transaction

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| trans.id | Unique identifier for the customer's order receipt. | INT | 11 | N/A | PK |
| Venue_ven.id | References where the purchase occurred. | INT | 11 | N/A | FK → Venue.ven.id |
| trans.datetime | The exact date and timestamp the purchase was made. | DATETIME | N/A | YYYY-MM-DD HH:MM:SS | |
| trans.total | The total dollar amount charged to the customer. | DECIMAL | 5 | N/A | |

---

## 5. Customer

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| cust.id | Unique identifier for the festival attendee. | INT | 11 | N/A | PK |
| cust.name | The first and last name of the customer. | VARCHAR | 45 | N/A | |
| cust.phone | Contact phone number for the customer. | VARCHAR | 10 | 10 digits | |
| cust.email | The customer's email address for digital ticket delivery. | VARCHAR | 45 | name@domain.com | |

---

## 6. Film

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| f.id | Unique identifier for the film. | INT | 11 | N/A | PK |
| f.title | The title of the film. | VARCHAR | 45 | N/A | |
| f.language | The primary spoken language of the film. | VARCHAR | 45 | N/A | |
| f.country | The country where the film was produced. | VARCHAR | 20 | N/A | |
| f.rating | The festival's internal quality rating. | INT | 11 | 1-10 | |
| f.runtime | The total runtime duration of the film. | TIME | N/A | HH:MM:SS | |
| P_director.id | References the lead director. | INT | 11 | N/A | FK → Primary Director.p_direct.id |
| A_director.id | References the assistant director. | INT | 11 | N/A | FK → Primary Director.p_direct.id |
| f.sub.id | References the organization that submitted the film. | INT | 11 | N/A | FK → Submission.sub.id |
| f.cat.code | References the competition category. | INT | 11 | N/A | FK → Category.cat.code |
| paired.film.id | References a companion film for double-features. | INT | 11 | N/A | FK → Film.f.id |

---

## 7. Menu Item

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| menu.id | Unique identifier for the specific food or drink product. | INT | 11 | N/A | PK |
| Vendor_ven.id | References the vendor who sells this item. | INT | 11 | N/A | FK → Vendor.ven.id |
| menu.name | The descriptive name of the item being sold. | VARCHAR | 45 | N/A | |
| menu.cost | The retail price of the item. | DECIMAL | 2 | Max 99 | |
| menu.calorie | The caloric count of the item. | INT | 11 | N/A | |

---

## 8. Primary Director

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| p_direct.id | Unique identifier for each director. | INT | 11 | N/A | PK |
| p_direct.fname | The director's first name. | VARCHAR | 45 | N/A | |
| p_direct.lname | The director's last name. | VARCHAR | 45 | N/A | |
| p_direct.phone | Contact phone number for the director. | VARCHAR | 10 | 10 digits | |

---

## 9. Reservation/Tickets

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| ticket.id | Unique identifier for the reservation block. | INT | 11 | N/A | PK |
| Customer_cust.id | References the ticket buyer. | INT | 11 | N/A | FK → Customer.cust.id |
| Screening_screen.id | References the specific screening event. | INT | 11 | N/A | FK → Screening.screen.id |
| ticket.seats | The total number of seats purchased. | INT | 11 | N/A | |
| ticket.checkin | Indicates if the customer has arrived. | VARCHAR | 45 | Yes|No | |

---

## 10. Screening

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| screen.id | Unique identifier for a specific screening event. | INT | 11 | N/A | PK |
| Film_f.id | References the movie being shown. | INT | 11 | N/A | FK → Film.f.id |
| screen.date | The calendar date the screening takes place. | DATE | N/A | YYYY-MM-DD | |
| screen.starttime | The time of day the screening begins. | TIME | N/A | HH:MM:SS | |

---

## 11. Screening Room

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| Venue_ven.id | References the location of the room. | INT | 11 | N/A | PK, FK → Venue.ven.id |
| Screening_screen.id | References the event taking place in the room. | INT | 11 | N/A | PK, FK → Screening.screen.id |
| SR.max_runtime | The maximum time blocked off for this room reservation. | TIME | N/A | HH:MM:SS | |
| SR.closedcaption | Indicates if the room supports closed captioning hardware. | VARCHAR | 3 | Yes|No | |
| SR.adaaccess | Indicates if the room is wheelchair accessible. | VARCHAR | 3 | Yes|No | |
| SR.maxcap | The maximum fire code seating capacity for the room. | VARCHAR | 45 | Numeric text | |

---

## 12. Shift

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| shift.id | Unique identifier for the scheduled shift block. | INT | 11 | N/A | PK |
| Venue_ven.id | References the venue location for the shift. | INT | 11 | N/A | PK, FK → Venue.ven.id |
| shift.date | The calendar date of the shift. | DATE | N/A | YYYY-MM-DD | |
| shift.stime | The start time of the shift. | TIME | N/A | HH:MM:SS | |
| shift.etime | The end time of the shift. | TIME | N/A | HH:MM:SS | |

---

## 13. Staff/Voulenteer

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| staff.id | Unique identifier for the employee or volunteer. | INT | 11 | N/A | PK |
| staff.fname | The staff member's first name. | VARCHAR | 45 | N/A | |
| staff.lname | The staff member's last name. | VARCHAR | 45 | N/A | |
| staff.trained | Indicates if they completed orientation. | VARCHAR | 3 | Yes|No | |
| staff.role | The specific job duty assigned to the staff member. | VARCHAR | 45 | N/A | |

---

## 14. Submission

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| sub.id | Unique identifier for the submitting organization. | INT | 11 | N/A | PK |
| sub.name | Name of the studio, school, or organization. | VARCHAR | 45 | N/A | |
| sub.phone | Contact phone number for the submitter. | VARCHAR | 10 | 10 digits | |
| sub.email | Contact email address for the submitter. | VARCHAR | 45 | name@domain.com | |

---

## 15. Transaction Line Item

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| Consession Transaction_trans.id | References the specific customer receipt. | INT | 11 | N/A | PK, FK → Consession Transaction.trans.id |
| Menu Item_menu.id | References the specific item purchased. | INT | 11 | N/A | PK, FK → Menu Item.menu.id |
| lineitem.quantity | The number of this specific item purchased. | INT | 11 | N/A | |
| lineitem.custom | Special instructions or modifications. | VARCHAR | 45 | N/A | |

---

## 16. Vendor

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| ven.id | Unique identifier for the food or merchandise vendor. | INT | 11 | N/A | PK |
| ven.name | The business name of the vendor. | VARCHAR | 45 | N/A | |
| ven.type | The category of the vendor. | VARCHAR | 45 | Food|Beverage | |
| ven.phone | Contact phone number for the vendor. | VARCHAR | 10 | 10 digits | |

---

## 17. Venue

| Column Name | Description | Data Type | Column Size | Format | Key |
|-------------|-------------|----------|-------------|--------|-----|
| ven.id | Unique identifier for the venue location. | INT | 11 | N/A | PK |
| ven.name | The name of the theater or event space. | VARCHAR | 45 | N/A | |
| ven.address | The physical street address of the venue. | VARCHAR | 45 | N/A | |
| ven.phone | Contact phone number for the venue's front desk. | VARCHAR | 10 | 10 digits | |

# Queries
<img width="457" height="526" alt="image" src="https://github.com/user-attachments/assets/5d2272f4-05ce-499f-bf8e-7be8907e61de" />


1. Revenue Analysis by Category 
Question: Which film categories are generating the most revenue from submission fees? Managerial Justification: Helps festival organizers identify the most profitable film categories to prioritize marketing and budget allocation for next year.
<img width="517" height="406" alt="image" src="https://github.com/user-attachments/assets/361f0292-be02-497b-bb6a-0317909176e4" />


2. Director Workload 
Question: Which directors are involved in the most films (as either Primary or Assistant Directors)? Managerial Justification: Allows the VIP relations team to identify the most active directors at the festival to ensure they receive appropriate hospitality and scheduling accommodations.
<img width="517" height="353" alt="image" src="https://github.com/user-attachments/assets/3c32788f-7ece-4c24-9a61-fae18c8fd3e7" />

3. Room Utilization 
Question: Identify screenings where the tickets sold represent less than 50% of the room's maximum capacity. Managerial Justification: Highlights underperforming screenings so the marketing team can run last-minute promotions or move future screenings to smaller, more cost-effective venues.
<img width="418" height="378" alt="image" src="https://github.com/user-attachments/assets/5c80a129-e3d6-4553-b655-f9caf2fe8f1d" />


4. Top Submitting Organizations 
Question: Which submitting organizations have provided the highest number of films to the festival? Managerial Justification: Identifies key institutional partners (like universities or studios) so the festival can build stronger B2B relationships and offer bulk submission discounts.
<img width="517" height="495" alt="image" src="https://github.com/user-attachments/assets/09ce64c9-3560-4455-9e98-fb9b2f63af96" />

5. Overall Customer Check-in Rate  Question: What is the overall check-in percentage for all ticket holders? Managerial Justification: Provides operations managers with a "no-show" metric, allowing them to confidently overbook high-demand screenings in the future without risking capacity issues.
<img width="517" height="187" alt="image" src="https://github.com/user-attachments/assets/7c2f88e7-b0cd-4515-8734-9b773b050f76" />

6. Above-Average Concession Sales 
Question: Which venues are generating individual concession transactions that are higher than the festival's overall average transaction amount? Managerial Justification: Helps inventory managers identify top-performing concession locations so they can prioritize restocking efforts and assign top sales staff to those venues.
<img width="517" height="373" alt="image" src="https://github.com/user-attachments/assets/d8a9da02-503e-475c-9f76-0ac5023c2ab3" />

7. Unassigned Staff 
Question: Which staff members and volunteers have not been assigned to any shifts?
Managerial Justification: Identifies unused volunteer labor so coordinators can quickly fill schedule gaps and maximize their workforce.

<img width="554" height="263" alt="image" src="https://github.com/user-attachments/assets/5f8178c8-f6c6-495d-97e6-0f18dfe9468a" />

8. Theatrical Venue Audit 
Question: Which venues have the word "Theatre", "Theater", or "Hall" in their name, and are actively hosting shifts?
Managerial Justification: Helps the marketing team quickly differentiate traditional theatrical venues from modern arenas so they can tailor photography assignments.
<img width="554" height="487" alt="image" src="https://github.com/user-attachments/assets/19482e50-3413-447c-9591-dfa3b5da9cea" />


9. Film Pairing Strategy 
Question: What are the specific titles of films that are paired with companion pieces for double features? Managerial Justification: Helps the programming and printing teams verify the festival brochure to ensure double-features are advertised correctly together.
<img width="517" height="453" alt="image" src="https://github.com/user-attachments/assets/3a187858-930d-4c13-8e28-f201fc97dffb" />

10. Opening Night Evening Shifts 
Question: What shifts are scheduled for the opening day of the festival (2026-05-10) that start at or after 4:00 PM (16:00:00), and at which venues?
Managerial Justification: Gives regional managers a clear operational schedule for the highest-traffic evening shifts on opening night.
<img width="554" height="246" alt="image" src="https://github.com/user-attachments/assets/b75d91a0-79a3-46ef-a2d5-568bd764f0e7" />

#Database information:
Name of the database: mb_B6

Additional information: Each query listed above is marked in the database using stored procedures which can be called using the following format: CALL GP_Q1();

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

INSERT DATA MODEL IMAGE HERE*******

# Data Dictionary

INSERT DATA DICTIONARY IMAGES HERE*****

# Queries

1. 

Question: Which film categories are generating the most revenue from submission fees? Managerial Justification: Helps festival organizers identify the most profitable film categories to prioritize marketing and budget allocation for next year.

2. 
Question: Which directors are involved in the most films (as either Primary or Assistant Directors)? Managerial Justification: Allows the VIP relations team to identify the most active directors at the festival to ensure they receive appropriate hospitality and scheduling accommodations.

3. 
Question: Identify screenings where the tickets sold represent less than 50% of the room's maximum capacity. Managerial Justification: Highlights underperforming screenings so the marketing team can run last-minute promotions or move future screenings to smaller, more cost-effective venues.

4. 
Question: Which submitting organizations have provided the highest number of films to the festival? Managerial Justification: Identifies key institutional partners (like universities or studios) so the festival can build stronger B2B relationships and offer bulk submission discounts.

5. 
Question: What is the overall check-in percentage for all ticket holders? Managerial Justification: Provides operations managers with a "no-show" metric, allowing them to confidently overbook high-demand screenings in the future without risking capacity issues.

6. 
Question: Which venues are generating individual concession transactions that are higher than the festival's overall average transaction amount? Managerial Justification: Helps inventory managers identify top-performing concession locations so they can prioritize restocking efforts and assign top sales staff to those venues.

7. 
Question: Which staff and volunteers are assigned to shifts but have not yet completed their required training? Managerial Justification: Crucial for liability and safety; allows HR to immediately contact untrained workers and pull them from the floor if necessary before their shift begins.

8. 
Question: Which specific venues and screening rooms are ADA accessible? Managerial Justification: Allows customer service representatives to quickly pull a list of compliant rooms to properly accommodate guests with disabilities and avoid compliance violations.

9. 
Question: What are the specific titles of films that are paired with companion pieces for double features? Managerial Justification: Helps the programming and printing teams verify the festival brochure to ensure double-features are advertised correctly together.

10. 
Question: What shifts are scheduled for the opening day of the festival (2026-05-10), and at which venues? Managerial Justification: Gives regional managers a clear operational schedule for opening day so they know exactly when and where to deploy their oversight teams.

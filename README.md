# social_network_system_design

### Functional Requirements:
* Create dialogs and chats
* Send and read messages
* Show read indicator
* Add and delete friends
* Post publication

### Non-Functional Requirements:
* DAU 50 000 000
* Each user sends 10 messages per day
* Each user reads 50 messages per day
* Message max size - 2000 symbols
* Keep messages for 5 years

### Back-of-the-envelope calculations:
* RPS (write) = 10 * 50 000 000 / 86 400 = 5 800 q/s
* RPS (read) = 50 * 50 000 000 / 86 400 = 29 000 q/s
* Traffic (write) = 5 800 * 2 000 * 2 = 23 MB/s
* Data = 23 * 86400 * 365 * 5 = 4 PB
* 200 SSD (4 GB) / 200 HHD (16 GB) - (20/80)
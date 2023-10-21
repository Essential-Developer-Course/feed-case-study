# feed-case-study

## Story: Customer request to see their image feed
### Narrative #1

**As** an online user  
**I Want** the app to automatically load my latest image feed  
**So I** can always enjoy the newest images of my friends

### Scenarios(Acceptance Criteria)

**Given** the customer has connectivity  
**When** the customer request to see the feed  
**Then** the app should show the latest feed from the remote

### Narrative #2

**As** an offline user    
**I Want** the app to show the latest saved version of my feed  
**So I** can always enjoy the images of my friends

### Scenarios(Acceptance Criteria)

**Given** the customer doesn't have connectivity  
**And** there's a cached version of the feed  
**When** the customer request to see the feed  
**Then** the app should show the latest feed saved

**Given** the customer doesn't have connectivity  
**And** the cache is empty  
**When** the customer request to see the feed  
**Then** the app should display an error message

## Load feed Use Case

**Data(Input)**   
- URL  

**Primary Course(happy path):**  
1. Execute "Load feed item" command with above data.  
2. System download data from the URL.  
3. System validates downloaded data.  
4. System creates feed items for downloaded data.  
5. System dilivers feed items.  

**Invalid data. error course (sad path):**  
1. System diliver error.  

## Load Feed Fallback (Cache) Use Case
**Data (Input):**  
- Max age

**Primary course (happy path):**  
1. Execute "Retrieve Feed Items" command with above data.  
2. System fetches feed data from cache.  
3. System creates feed items from cached data.  
4. System delivers feed items.  

**No cache course (sad path):**  
1. System delivers no feed items.    

## Save Feed Items Use Case
**Data (Input):**  
- Feed items  

**Primary course (happy path):**  
1. Execute "Save Feed Items" command with above data.  
2. System encodes feed items.  
3. System timestamps the new cache.  
4. System replaces the cache with new data.  
5. System delivers a success message.  








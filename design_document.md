# Project Goal

This is a Dart-based project that uses Flutter as the framework. The goal is to create a vending machine where the user can insert money and receive an item in exchange. It will have a centralized storage system based on Supabase, as well as a local database system to manage the money. The system will have two modes: the default state is the user mode (accessed by normal user), and the admin mode is accessed by inserting an admin card and entering the correct password. (admin is able to change the available products, restock and remove products).

---

## What You See on Opening the App

When first opening the app the user sees a vending machine with all its available products in a grid format. The machine has a sidebar which has an "insert money" and "return money" button. The sidebar has also a coin & bill-slit, input field and a coin tray. On the bottom is a section to take the bought item out.

---
### Process
Customer wants to buy something -> He clicks on a product from the product card. The products details are shown and he can cancel and go back or press buy. On buy it will check wether a transaction is possible. First his inserted money will be checked which is empty. He is told to first insert money. He is returned back and should now click on the money slits on the sidebar. This opens a Window where he can insert coins varying from 2€ down to 0.01€ coins. If the customer is contend with his insertion he can press ok or cancel. Cancel results in returning the money back to the coin tray. If he presses ok then the money is ready for transaction. customer can now again try to buy something. If he has enough money then the machine will check wether it can give back change money or not. If yes then the transaction will be fulfilled by giving out the selected item and giving out the change. If the machine can not exchange the money, then the transaction is canceled his money is returned to the coin tray and the customer is told to insert the right amount for the product he wants to buy because the machine cant give change back. 
The user can enter the admin mode by clicking the admin mode button. He will be asked to enter a password. After successfully entering the admin mode he can restock/remove snacks and either refill or empty the coin stack. He can leave admin mode any time.

---
# Models

```
ITEM SLOT {SLOT ID, ITEM}

ITEM {
    ITEM ID "STRING",
    ITEM NAME "STRING",
    ITEM AMOUNT "INT",
    ITEM PRICE IN CENTS "INT"
}

COINSTACK {
    MAP<int,int> {
}
    get sum of all coin
}

```

---


# GUI

## Sidebar

### Coin slot

A clickable widget.

### Bill slit

A clickable Widget.

### Input field

A visual widget with no function.

### Coin tray
The coin tray is a container widget which, when the user has returned his money or bought an item and there is exchange money left, becomes clickable. If the user does not take out the money from the coin tray and gets more money exchanged (after another transaction), then the new exchange money is added onto the old exchange money.

## Product Area

#### Product slot

Is a clickable Container widget. Has a column child with:

1. its product number
2. product picture (2D icon)
3. product price
   On tap: buy window opens

## Dispensing Area

#### Dispensing slot

Is below the sidebar and the product area, which becomes clickable after a product has been bought. On tap: the item is taken out.

## Database
The whole data is stored in Supabase. The will be 2 separate storages. One is the vending machine itself, the other is are depot somewhere else. Both look the same, having snacks and coin stack. 

### Vending Machine DB
The vending machine has a limited storage. Each Slot can hold a total amount of 20 snacks. Since the Machine has 9 Slots the can be 180 snacks stored in the vending machine. So the table should have 9 rows. Each row having a slot id as Primary Key. Product id is the Foreign Key and then the amount of each snack (capped at 20). It also has a Coin Stack with all € coins which is the Primary Key and also the amount of each Coin. Coins are capped 2€ at 500 1€, 0.50€ at 1000 0.20€ 0.10€ 0.05€ at 1200 and 0.02€ 0.01€ at 1500.

### Storage DB
The storage is very similar except that it has a table with the Snack ID as Primary Key and an amount. The amount of Rows is based on the amount of different Snacks available. The Coin Stack is the same as vending machine except that it has no limit to the amount. The numbers can not exceed a number which is < 0.

## Admin

The admin mode is accessed by long pressing the admin button, which opens a number field expecting a correct password. The user will enter admin mode after inserting the correct password and confirming.  
**Password:** "0000"

The admin mode appears like the normal customer mode. A label appears on the machine saying "ADMIN". Here you can click on any product in the card which instead of opening the buy window, opens a management window, in which you can change the snack with another or increase or decrease the stock. If you set the amount to 0 then the card will just display an empty slot. The changes are made and synchronized with the database when the button confirm is being pressed. Upon clicking on the money slits you can add or take coins out of the coin stack. Same confirming process like the snacks. To leave the admin mode hold the "button customer" mode.

---

### money exchange algorithm

calcExchangeMoney(int centsToBeExchanged)
This function attempts to calculate how a given amount of change (in cents) can be composed using the currently available coins in the vending machine.
It returns a map where each key represents a coin value and each value represents how many coins of that type should be used to make up the required amount.

If an exact exchange is possible using the available coin denominations and quantities, the function returns the corresponding map of coins.
If an exact exchange cannot be achieved with the available coins, the function returns null.

Internally, the function tries different combinations of coin denominations to find a valid exchange starting from the largest available coin and moving to smaller ones. It ensures that the available coin quantities are respected.

_tryExchangeFrom(startIndex, availableCoins, result, remaining)
This helper function tries to create an exact exchange starting from a specific coin denomination (determined by startIndex).
It recursively or iteratively tests combinations of coins to see if the target amount can be achieved without exceeding the available coin stock.
It returns true if an exact exchange is found and updates the result map; otherwise, it returns false, signaling that the next possible variant should be tried.

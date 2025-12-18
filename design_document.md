# Project Goal

This is a Dart-based project that uses Flutter as the framework. The goal is to create a vending machine where the user can insert money and receive an item in exchange. It will have a centralized storage system based on Supabase, as well as a local database system to manage the money. The system will have two modes: the default state is the user mode (accessed by normal user), and the admin mode is accessed by inserting an admin card and entering the correct password. (admin is able to change the available products, restock and remove products).

---

## What You See on Opening the App

When first opening the app the user sees a vending machine with all its available products in a grid format. The machine has a sidebar which has an "insert money" and "return money" button. The sidebar has also a coin & bill-slit, input field and a coin tray. On the bottom is a section to take the bought item out.

---

# Models

<span id=coinstack></id>

```
ITEM SLOT {SLOT ID, ITEM}

ITEM {
    ITEM ID "STRING",
    ITEM NAME "STRING",
    ITEM AMOUNT "INT",
    ITEM PRICE IN CENTS "INT"
}

COINSTACK {
    MAP<COIN,int> {
        COIN(1): 100,
        COIN(2): 100,
        COIN(5): 100,
        COIN(10): 100,
        COIN(20): 100,
        COIN(50): 100,
        COIN(100): 100,
        COIN(200): 100,
    }
    get sum of all coin
}

COIN {
    constructor(required this.cent)
    int cent
}
```

---

<span id=insert_money_window></id>

# GUI

## Sidebar

#### Coin slot

A visual widget with no function.

#### Bill slit

A visual widget with no function.

#### Input field

A visual widget with no function.

#### Insert money button

Is a button above the return money button. On tap: <a href=#open_insert_money_window> openInsertMoneyWindow()</a>.

<span id=return_money_button></id>

#### Return money button

Is placed on the <a href = #sidebar>sidebar</a> above <a href=#input_field>input field</a><br> On tap: <a href=#return_money>return money()</a>. If money is returned into the <a href = #coin_tray>coin tray</a> it becomes clickable.

<span id=coin_tray></id>

#### Coin tray

The coin tray is a container widget which, when the user has returned his money or bought an item and there is exchange money left, becomes clickable. On tap: <a href=#return_money> return money() </a>. If the user does not take out the money from the coin tray and gets more money exchanged (after another transaction), then the new exchange money is added onto the old exchange money.

<span id=item_slot></id>

## Product Area

#### Product slot

Is a clickable Container widget. Has a column child with:

1. its product number
2. product picture (2D icon)
3. product price  
   On tap: <a href=#buyItem> buyItem()</a>.

## Dispensing Area

<span id=dispensing_slot></id>

#### Dispensing slot

Is below the sidebar and the product area, which becomes clickable after a product has been bought. On tap: <a href=#takeOutItem> takeOutItem() </a>.

### Conditional

#### Admin password window

An AlertDialog and a number field appear which ask the user to input a password. The user can close the window (which resets the input field) or confirm. If the password is correct the user will enter admin mode. If it is wrong, he will be notified "wrong password".

#### Insert money window

An AlertDialog and a number field appear where the user sees all available € coins. On tapping any coin, it will save the coin in a temp account. The user has the option to close the window (which resets the textfield) or press the confirm button, which then returns the amount of each coin and adds them to the purchase total and resets the textfield.

---

## Database

## Admin

The admin mode is accessed by long pressing the admin button, which opens a number field expecting a correct password. The user will enter admin mode after inserting the correct password and confirming.  
**Password:** "0000"

---

## Functionalities

### insertCoin(COIN)

The value of the coin is matched with the coin in the map <a href=#coinstack>COINSTACK</a> and increases the int value by one for each matching coin.

<span id=open_insert_money_window></id>

### openInsertMoneyWindow()

On tap: <a href=#insert_money_window>insert money window</a> opens.

<span id=return_money></id>

### returnMoney()

All the money which is left in the machine’s user account is returned into the coin tray.

<span id=buyItem></id>

### buyItem(item)

If there is no money or not enough money then nothing happens, and the user is notified and told to insert money. If there is an item in the <a href=#dispensing_slot>dispensing slot</a>, the user is notified that he should empty it.  
Else, the item amount is checked:  
If amount > 0 → the item amount is reduced by 1 and the user’s inserted money will be subtracted by the cost amount. Then the remaining money will be collectable by the user from the <a href=#coin_tray>coin tray</a>.  
If amount ≤ 0 → the user will be notified that there is no item to buy.

<span id=takeOutItem></id>

### takeOutItem()

The dispensing slot is emptied. A check icon will pop up for better feedback. If the dispensing slot is empty then the user will be notified that the dispensing slot is empty.

### takeOutMoney(value)

The value is returned into the user’s wallet.

### map<int, int> calcExchangeMoney(int centsToBeExchanged)

Create empty map = map of coinstack to exchange the centsToBeExchanged (result).  
Create int variable = remaining coins to be exchanged (remaining).  
Copy current coin stash <map> = via copy with method (availableCoins).

Try the first possible variant and if fails, then it will try to exchange with a next possible variant.  
i.e. if can't exchange 60ct with <= coin 50ct and other smaller coins then it will reset everything and start with the next coin which is < 50ct (20ct) and so on...

```
for (int startIndex = 0; startIndex < coins.length; startIndex++) {
    result = {};
    remaining = centsToBeExchanged;
    availableCoins = Map.from(coins);
}
```

Check whether the helper function "\_tryExchangeFrom()" returned true or false.  
If true then we return the result and if false we return null because we can not exchange the exchange money.

### bool \_tryExchangeFrom(startIndex, availableCoins, result, remaining)

With the following function we ensure that we start with a Coin which is <= remaining exchange.  
And if the try fails completely we go back to the loop from the function calcExchangeMoney:

```
Create a list from the map availableCoins with a simple .toList() so we can go through each coin index with a loop. (availableCoinsList).
loop (int index = startIndex; index < availableCoinsList.length; index++){
    by overriding the index with our start index we ensure that we start calculating not on the first pos of the map rather we start at the wanted coin.
    save the current entry of availableCoinsList at the current index so we can jump from one coin to the next smallest coin.
    save and override integer coinValue and coinAmount for each iteration at the current index.

    check whether coinValue is bigger than remaining exchange
    yes: continue;
    no: keep going in current iteration.

    to know how many coins should be subtracted from available coin map and how many to add to result map.
    a max possible coin. If the max possible coin amount is bigger than our current coin amount then we will subtract all current available amount of our coin.
    save the amount needed in a variable (amountOfCoinNeeded)
    get the max possible coin by dividing <int> remaining exchange with our <int> coinValue.
    if our amountOfCoinsNeeded is 0 then we skip the calc and start another iteration with the next smaller coin.
    if not then we add to our result map the amountOfCoinsNeeded to the specific value. i.e. we calc with 50ct coin then we add that to the map and give it amountOfCoinsNeeded as amount.
    subtract from our availableCoins Map the amount of that coin.
    as last calc step: remaining -= coinValue * amountOfCoinNeeded;

    if remaining == 0
    yes: return true
    no: continue iterating

    return false after all iterations.
}
```

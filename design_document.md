# Project Goal

This is a Dart-based project that uses Flutter as the framework. The goal is to create a vending machine where the user can insert money and receive an item in exchange. It will have a centralized storage system based on Supabase, as well as a local database system to manage the money. The system will have two modes: the default state is the user mode (accessed by normal user), and the admin mode is accessed by inserting an admin card and entering the correct password. (admin is able to change the available procuts, restock and remove products).
___

## what you see on opening the app
when first opening the app the user sees a vending machine with all its available products in a grid format. The machine has a sidebar which has an "insert money" and "return money" button. The sidebar has also a coin & bill-slit, input field and a coin tray 
On the bottom is a section to take the bought item out.
___
## models

<span id=coinstack></id>

```
ITEM SLOT {SLOT ID, ITEM}

ITEM {
    ITEM ID "STRING",
    ITEM NAME"STRING",
    ITEM AMOUNT"INT,
    ITEM PRICE IN CENTS"INT"}


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
        constuctor(required this.cent)
        int cent
    }

```
___




<span id=insert_money_window></id>

___
#  GUI:

## sidebar

#### coin slot
a visual widget with no function

#### bill slit
a visual widget with no function

#### inputfield
a visual widget with no function.

#### insert money button
is a button obove the return money button.
on tap:  <a href=#open_insert_money_window> openInsertMoneyWindow()</a>
<span id= return_money_button></id>

#### return money button
is placed on the <a href = #sidebar>sidebar</a> obove <a href=#input_field>input field</a><br>
 on tap: <a href=#return_money>return money()</a>
 if money is returned into the <a href = #coin_tray>coin tray</a> it becomes clickable.

<span id = coin_tray></id>

#### coin tray
the coin tray is a container widget which when the user has returned his money or bought an item and there is exchange money left becomes clickable. on tap: <a href=#return_money> return money() </a>. If the user does not take out the money from the coin tray and gets more money exchanged i.e after another transaction, then the new exchange money is added onto the old exchange money.
<span id = item_slot></id>

## product area

<span id=item_slot></id>

#### product slot
is a clickable Container widget.Has a column child with 1. its product number 2. product picture (2d icon) 3. product price.
 on tap: <a href=#buyItem> buyItem()</a>



## dispension area
<span id = dispensing_slot></id>

#### dispensing slot
is below the sidebar and the product area which becomes clickable after a product has been bought.
on tap:
<a href=#takeOutItem> takeOutItem() </a>


### conditional

#### admin password window
a AltertDialogue and a numberfield appears which asks the user to input a password. The user can close the window which resets the inputfield or confirm. If the password is correct the user will enter the admin mode. If it is wrong he will be notified "wrong password"

#### insert money window
a AlertDialogue and a number field appears up where the user sees all availabe € coins. on tapping any coin it will safe the coin in a temp account. The user has the option to close the window which resets the textfield. 
Or press the confirm button which then returns the amount of each coin and adds them to the purchase total and resets the textfield.
___


## Database

## Admin
the admin mode is accessed by long pressing the admin button which opens a number field expecting a correct password. The user will enter admin mode after inserting the correct password and confirming.
Password: "0000"

## functionalities

#### insertCoin(COIN)
The value of the coin is matched with the coin in the map <a href=#coinstack>COINSTACK</a> and increases the int value by one for each matching coin. 


<span id=open_insert_money_window></id>

#### openInsertMoneyWindow()
on tap: <a href=#insert_money_window>insert money window</a> opens.

<span id=return_money></id>

#### returnMoney()
 all the money which is left in the machines user account is returned into the coin tray.

<span id = buyItem></id>

 #### buyItem(item)
If there is no money or not enough money then nothing happens and the user is notified and told to insert money.
if there is an item in the <a href =#dispensing_slot> dispensing slot</a> the user is notified that he should empty it.
Else 
The item amount is checked. If amount > 0: the item amount is reduced by 1 and the users inserted money will be subtracted by the cost amount. Then the remaining money will be collectable by the user from the <a href = #coin_tray>coin tray</a>
if <=0: the user will be notified that there is no item to buy.


<span id= takeOutItem></id>

 #### takeOutitem()
the dispensing slot is emptied. And a check icon will popup for better feedback.
if the dispensing slot is empty then the user will be notified that the dispensing slot is empty.

 #### takeOutMoney(value)
 the value is returned into the users wallet
 
#### map<int, int> calcExchangeMoney(int centsToBeExchanged)

    create empty map = map of coinstack to exchange the centsToBeExchanged (result).
    create int variable = remaining coins to be exchanged (remaining)
    copy current coin stash <map> = via copy with method (availableCoins)

    try the first possible variant and if fails, then it will try to exchange with a next possible variant.
    i.e if can't exchange 60ct with <= coin 50ct and other smaller coins then it will reset everything and start with the next coin which is < 50ct (20ct) and so on...
    for (int startIndex = 0; startIndex < coins.length; startIndex++) {
        result = {};
        remaining = centsToBeExchanged;
        availableCoins = Map.from(coins);
        }
    check wether the helper function "_tryExchangeFrom()" returned true or false.
    if true then we return the result and if false we return null.

#### _tryExchangeFrom(startIndex, availableCoins, result, remaining)



class Coinstack {
  Map<int, int> coins;

  Coinstack(this.coins);

  Map<int, int>? exchange(int amountInCent) {
    int remaining = 0;
    Map<int, int> availableCoins = Map.from(coins);
    Map<int, int> result = {};
    for (int startIndex = 0; startIndex < coins.length; startIndex++) {
        result = {};
        remaining = amountInCent;
        availableCoins = Map.from(coins);

      if (_tryExchangeFrom(startIndex, availableCoins, result, remaining)) {
        return result;
      }
    }
    return null;
  }

  bool _tryExchangeFrom(
    int startIndex,
    Map<int, int> availableCoins,
    Map<int, int> result,
    int remaining,
  ) {
    final availableCoinsList = availableCoins.entries.toList();
    
    for (int index = startIndex; index < availableCoinsList.length; index++) {
      final entry = availableCoinsList[index];
      int coinValue = entry.key;
      int coinAmount = entry.value;

      if (coinValue > remaining) {
        continue;
      }
      int maxPossible = remaining ~/ coinValue;
      int amountOfCoinNeeded = maxPossible < coinAmount
          ? maxPossible
          : coinAmount;

      if (amountOfCoinNeeded > 0) {
        result[coinValue] = (result[coinValue] ?? 0) + amountOfCoinNeeded;
        availableCoins[coinValue] = coinAmount - amountOfCoinNeeded;
        remaining -= coinValue * amountOfCoinNeeded;
      }

      if (remaining == 0) {
        return true;
      }
    }
    return false;
  }
}

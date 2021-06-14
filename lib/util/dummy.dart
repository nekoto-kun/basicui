import '../model/card.dart';
import '../model/message.dart';
import '../model/transaction.dart';
import '../model/writeoff.dart';

final dummyTransactions = <Transaction>[
  Transaction(
    id: 1,
    title: 'Ordered Lele × 2',
    category: 'Food & Drinks',
    image: 'foods.png',
    amount: 18000,
  ),
  Transaction(
    id: 2,
    title: 'Paid electricity bill',
    category: 'Bills',
    image: 'bill.png',
    amount: 128000,
  ),
  Transaction(
    id: 3,
    title: 'Paid course subscription',
    category: 'Subscriptions',
    image: 'subs.png',
    amount: 1800000,
  ),
  Transaction(
    id: 4,
    title: 'Bought groceries',
    category: 'Groceries',
    image: 'grocery.png',
    amount: 225000,
  ),
  Transaction(
    id: 5,
    title: 'Paid credit debt',
    category: 'Debts',
    image: 'debt.png',
    amount: 300000,
  ),
  Transaction(
    id: 6,
    title: 'Bought keyboard',
    category: 'Electronics',
    image: 'electronics.png',
    amount: 778000,
  ),
];

final dummyCards = <BankCard>[
  BankCard(
    id: 1,
    name: 'General Debit',
    color: 'dark',
    cardNumber: '1234 5678 9876 3210',
    type: 'mastercard',
    balance: 5000000,
  ),
  BankCard(
    id: 2,
    name: 'Freelance Debit',
    color: 'white',
    cardNumber: '1234 5678 9876 3210',
    type: 'visa',
    balance: 1700000,
  ),
  BankCard(
    id: 3,
    name: 'Billing Debit',
    color: 'blue',
    cardNumber: '1234 5678 9876 3210',
    type: 'mastercard',
    balance: 2100000,
  ),
];

final dummyWriteOffs = <WriteOff>[
  WriteOff(
    name: 'Netflix',
    amount: 186000,
    category: 'Subscription',
    daysBeforeCancel: 4,
    assetIcon: 'netflix-desktop-app.png',
  ),
  WriteOff(
    name: 'Citi Bank',
    amount: 200000,
    category: 'Payment',
    daysBeforeCancel: 15,
    assetIcon: 'citibank-squared.png',
  ),
  WriteOff(
    name: 'Duolingo',
    amount: 175000,
    category: 'Subscription',
    daysBeforeCancel: 9,
    assetIcon: 'duolingo-logo.png',
  ),
  WriteOff(
    name: 'Medium',
    amount: 135500,
    category: 'Subscription',
    daysBeforeCancel: 21,
    assetIcon: 'medium-logo.png',
  ),
];

final messages = <Message>[
  Message(
    id: 1,
    message: 'Ahoy!',
    sender: 'Billy',
    sentBy: DateTime.now(),
  ),
  Message(
    id: 2,
    message: 'What do you do?',
    sender: 'Alissa',
    sentBy: DateTime.now(),
  ),
  Message(
    id: 3,
    message: 'I\'ve sent the money',
    sender: 'Cal',
    sentBy: DateTime.now(),
  ),
  Message(
    id: 4,
    message: 'You owe me this much!',
    sender: 'Dustin',
    sentBy: DateTime.now(),
  ),
  Message(
    id: 5,
    message: 'When will you pay?!',
    sender: 'Erikk',
    sentBy: DateTime.now(),
  ),
  Message(
    id: 6,
    message: 'This is your payment. Take care.',
    sender: 'Fiona',
    sentBy: DateTime.now(),
  ),
];

import 'package:basicui/model/card.dart';
import 'package:basicui/model/transaction.dart';

final dummyData = <Transaction>[
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

final cards = <BankCard>[
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

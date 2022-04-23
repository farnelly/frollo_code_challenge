# Frollo Backend Code Challenge

# Introduction
The application allows the users to list the transaction, get transaction and create a transaction.

The application is built with ruby on rails.

# Getting started
### Built with
This app is built with lots of love along with ruby `2.6.5`.

Please follow [this link](https://github.com/rbenv/rbenv#installation) to install ruby version manager `rbenv` and install ruby on your local environment. 

To confirm if the correct version of ruby is installed locally, please run the following.
```
ruby -v
``

## Browser Requirements

| Browsers |
| -------- |
| Safari 6.1+|
| Google Chrome 23+ |
| Internet Explorer 11+ |
| Firefox 16+ |

### Install operational dependencies
Operational dependencies are usually servers that your app uses to store sessions, cache or persistent data eg. postgresql database, redis server etc.

```sh
brew install postgres
```
`Brew` spits out post configuration that might be needed to run the servers after the installation. Please pay attention to that.


### Clone the repo and change the directory to the project
```sh
git clone git@github.com:pratikghimire/frollo_code_challenge.git
cd frollo_code_challenge
```

### Install dependencies
```
bundle install
```

### Prepare your database
```sh
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed

RAILS_ENV=test bundle exec rake db:test:prepare
```

### Run the app
```
bundle exec rails s
```

## Testing
[Rspec](https://rspec.info/) is as a tool for TDD and writing tests. To run the automated tests, please run the following
```
bundle exec rspec
```
All specs should be green 🍏

## Quality
[Rubocop](https://rubocop.org/) is used for linting (style check). To check for lints, please run the following
```
bundle exec rubocop
```
Rubocop output should be green 🍏

-------------

## Overview

This is a simple code challenge to help assess a candidate's knowledge and experience with building RESTful APIs. This challenge will touch on a few concepts that we use frequently at Frollo. The main areas this challenge will assess are:
* RESTful API development
* Writing and retrieving data from a database
* Writing asynchronous jobs
* Writing unit tests

On top of this, the challenge will introduce you to some of the domain language used at Frollo; transactions and categorisation! Don't worry, the categorisation code will be given to you and it will be your task to wrap it up in an asynchronous job.

You will be assessed on the following criteria:
* Your ability to write clean, concise code
* Code that is written in such a way that allows it to be unit tested easily
* The unit tests that you write

This folder contains a fresh Rails app that you can build on top of to complete the challenge.

## What You Need To Do
This section simply states the outcomes you will do as part of this challenge. The [Overview](#overview), [Challenge Description](#challenge-description) and [APIs To Create](#apis-to-create) section provide more details.
1. Create a git repository and commit your work as you go
2. Create a POST /transactions API that saves a transaction to the database
3. Create an asynchronous job that will be triggered after the transaction is created. This will categorise the transaction.
4. Create a GET /transaction/:id API that returns the tranasction specified by ID
5. Create a GET /transactions API that will return all transactions in the database
6. Write unit tests to test the APIs and asyncnour job.
  1. NOTE: There is no need to unit test the catgorisation code provided to you

## Challenge Description

Your task will be to create 3 REST APIs that let a client create and retrieve transactions. A summary of the APIs:
* Create Transaction (POST /transactions)
  * Save a transaction to the database and start the categorisation process for it
* Get Transaction By ID (GET /transactions/:id)
* Get Transactions (GET /transactions)

The second component of this challenge will be to create the "categorisation process". This will be an asynchronous job that will run after a transaction is created and categorise it using the code in the `app/services/categorisation.rb` file.

There is some test data outlined in the `test_data.csv` file.

### Assumptions
For simplicity we will make the following assumptions:
* The transaction does not need to belong to an account or user object. It can simply live on it's own.
* There will be no API authentication.
* The categorisation code should be used as-is (this challenge is not about actually categorising a transaction, but writing the backend code to support it)

### Asynchronous Categorisation Job
Please feel free to use any asynchonous job gem that you are familiar with. We use Sidekiq at Frollo, but it is not required to use that one for this challenge. Some gems are:
* Sidekiq: https://github.com/mperham/sidekiq
* Active Job: https://guides.rubyonrails.org/active_job_basics.html
* Resque: https://github.com/resque/resque

Please also note: if you have not had any experience with background job creation then you can opt out of this part of the challenge and just call the cateogrisation code synchronously within the POST /transactions API.

## APIs To Create
### Create Transaction
This API will be used to create a Transaction in the system. This API will have the following behaviour:
1. Perform any data validation on the request body
2. Save the transaction to the database
3. Start an asynchronous job that will categorises this transaction
4. Return the created transaction as a response body

#### Request
```js
POST /api/transactions
request body:
{
    posted_date: '2021-01-01', // String with date format
    currency: 'AUD', // String, allowed values: 'AUD', 'USD', 'GPD'
    amount: 100.00, // Number (kept as number for simplicity of the challenge)
    description: 'This is a test', // Max length 300
    type: 'PAYMENT' // String, allowed values: 'TRANSFER_OUTGOING', 'TRANSFER_INCOMING', 'PAYMENT', 'OTHER'
}
```

#### Response
```js
{
    id: 1, // Generated by the system
    posted_date: '2021-01-01',
    currency: 'AUD',
    amount: 100.00,
    description: 'This is a test',
    type: 'PAYMENT',
    category: 'Uncategorised' // Generated by the system
}
```

### Get Transaction By ID
#### Request
```
GET /api/transactions/:id
```

#### Response
```js
{
    id: 1,
    posted_date: '2021-01-01',
    currency: 'AUD',
    amount: 100.00,
    description: 'This is a test',
    type: 'PAYMENT',
    category: 'Uncategorised'
}
```

### Get Transactions
#### Request
```
GET /api/transactions
```

#### Response
```js
[
    {
        id: 1,
        posted_date: '2021-01-01',
        currency: 'AUD',
        amount: 100.00,
        description: 'This is a test',
        type: 'PAYMENT',
        category: 'Uncategorised'
    },
    {
        id: 2,
        posted_date: '2021-01-01',
        currency: 'AUD',
        amount: 100.00,
        description: 'This is a test',
        type: 'PAYMENT',
        category: 'Uncategorised'
    }
]
```
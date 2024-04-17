# Amazon Clone API

This API provides functionalities similar to an Amazon clone. It allows users to register, login, logout, and perform various actions related to authors and books.

## Table of Contents
- [Setup](#setup)
- [Registration](#registration)
- [Authentication](#authentication)
- [Authors](#authors)
    - [Retrieve All Authors](#retrieve-all-authors)
    - [Retrieve an Author with Their Books](#retrieve-an-author-with-their-books)
    - [Create an Author](#create-an-author)
    - [Delete an Author](#delete-an-author)
- [Books](#books)
    - [Retrieve All Books](#retrieve-all-books)
    - [Retrieve a Book](#retrieve-a-book)
    - [Create a Book](#create-a-book)
    - [Delete a Book](#delete-a-book)
- [Confirmation](#confirmation)
    - [Resend Confirmation Email](#resend-confirmation-email)
- [Request and response formats](#request-and-response-formats)


## Setup

1. Clone the Amazon Clone API repository from GitHub:

   ```
   git clone https://github.com/t-ega/amazon-clone-api.git
   ```

2. Navigate to the project directory:

   ```
   cd amazon-clone-api
   ```

3. Install the required gems specified in the Gemfile:

   ```
   bundle install
   ```

4. Set up the database by running the following commands:

   ```
   rails db:create
   rails db:migrate
   ```

5. Set up the environment variables by creating a `.env` file in the project root directory. You can use the following template and replace the values with your own:

   ```
   PORT=3000
   DATABASE_URL=mongodb://localhost:27017/amazon_clone
   JWT_SECRET=your-secret-key
   EMAIL_API_KEY=your-email-api-key
   EMAIL_SENDER=your-email-sender
   ```

    - `PORT`: The port number on which the API should run (default: 3000).
    - `DATABASE_URL`: The URL of your MongoDB database.
    - `JWT_SECRET`: A secret key used for JWT token generation and verification.
    - `EMAIL_API_KEY`: API key for the email service provider (e.g., SendGrid, Mailgun).
    - `EMAIL_SENDER`: Email address from which confirmation emails will be sent.

6. Start the Rails server:

   ```
   rails server
   ```

   The API should now be running and accessible at `http://localhost:3000` (or the specified port).

## Registration

To register a new user, send a POST request to `/api/v1/auth/signup` with the following parameters in the request body:

- `name` (string): User's name
- `email` (string): User's email address
- `phone` (string): User's phone number
- `password` (string): User's password
- `password_confirmation` (string): Confirmation of the user's password

If successful, the API will send a confirmation email to the provided email address. The response will contain a message indicating the successful registration and provide instructions to check the email for a confirmation token.

## Authentication

To authenticate and log in a user, send a POST request to `/api/v1/auth/login` with the following parameters in the request body:

- `email` (string): User's email address
- `password` (string): User's password

If the provided credentials are correct, the API will respond with a JSON object containing a token. Include this token in the headers of subsequent requests to authenticate the user.

## Authors

### Retrieve All Authors

To retrieve a list of all authors, send a GET request to `/api/v1/authors`.

### Retrieve an Author with Their Books

To retrieve a specific author and their associated books, send a GET request to `/api/v1/authors/:id`, where `:id` is the ID of the author.

### Create an Author

To create a new author, send a POST request to `/api/v1/authors` with the following parameters in the request body:

- `first_name` (string): Author's first name
- `last_name` (string): Author's last name
- `age` (integer): Author's age
- `user_id` (integer): ID of the associated user (optional)

### Delete an Author

To delete an author, send a DELETE request to `/api/v1/authors/:id`, where `:id` is the ID of the author.

## Books

### Retrieve All Books

To retrieve a list of all books, send a GET request to `/api/v1/books`.

### Retrieve a Book

To retrieve a specific book, send a GET request to `/api/v1/books/:id`, where `:id` is the ID of the book.

### Create a Book

To create a new book, send a POST request to `/api/v1/books` with the following parameters in the request body:

- `title` (string): Title of the book
- `author_id` (integer): ID of the associated author
- `price` (float): Price of the book

### Delete a Book

To delete a book, send a DELETE request to `/api/v1/books/:id`, where `:id` is the ID of the book.

## Confirmation

### Resend Confirmation Email

To resend the confirmation email for a registered user, send a POST request to `/api/v1/confirmations`. Include the following parameter in the request body:

- `email` (string): User's email address

If the email is associated with a registered user, the API will resend the confirmation email to that address.

Note: All requests to this API, except for registration and confirmation, require authentication. Include the authentication token in the headers of these requests by adding an `Authorization` header with the value `Bearer [token]`, where `[token]` is the received authentication token.

Please make sure to handle appropriate error responses and handle exceptions in your application when interacting with this API.

Sure! Here are some request and response samples for the API endpoints:

## Request and Response Formats

### Registration

**Request:**

```
POST /api/v1/auth/signup

{
  "name": "John Doe",
  "email": "johndoe@example.com",
  "phone": "1234567890",
  "password": "secretpassword",
  "password_confirmation": "secretpassword"
}
```

**Response:**

```
Status: 201 Created

{
  "message": "Sign-up successful. Check email for confirmation token"
}
```

### Authentication

**Request:**

```
POST /api/v1/auth/login

{
  "email": "johndoe@example.com",
  "password": "secretpassword"
}
```

**Response:**

```
Status: 200 OK

{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzIxfQ.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}
```

### Retrieve All Authors

**Request:**

```
GET /api/v1/authors
```

**Response:**

```
Status: 200 OK

[
  {
    "id": 1,
    "first_name": "Jane",
    "last_name": "Doe",
    "age": 35
  },
  {
    "id": 2,
    "first_name": "John",
    "last_name": "Smith",
    "age": 42
  }
]
```

### Retrieve an Author with Their Books

**Request:**

```
GET /api/v1/authors/1
```

**Response:**

```
Status: 200 OK

{
  "author": {
    "id": 1,
    "first_name": "Jane",
    "last_name": "Doe",
    "age": 35,
    "books": [
      {
        "id": 1,
        "title": "Book 1",
        "price": 19.99
      },
      {
        "id": 2,
        "title": "Book 2",
        "price": 14.99
      }
    ]
  }
}
```

### Create an Author

**Request:**

```
POST /api/v1/authors

{
  "first_name": "Alice",
  "last_name": "Johnson",
  "age": 28,
  "user_id": 1
}
```

**Response:**

```
Status: 201 Created

{
  "author": {
    "id": 3,
    "first_name": "Alice",
    "last_name": "Johnson",
    "age": 28,
    "user_id": 1
  }
}
```

### Delete an Author

**Request:**

```
DELETE /api/v1/authors/2
```

**Response:**

```
Status: 204 No Content
```

### Retrieve All Books

**Request:**

```
GET /api/v1/books
```

**Response:**

```
Status: 200 OK

[
  {
    "id": 1,
    "title": "Book 1",
    "author_id": 1,
    "price": 19.99
  },
  {
    "id": 2,
    "title": "Book 2",
    "author_id": 1,
    "price": 14.99
  }
]
```

### Retrieve a Book

**Request:**

```
GET /api/v1/books/1
```

**Response:**

```
Status: 200 OK

{
  "id": 1,
  "title": "Book 1",
  "author_id": 1,
  "price": 19.99
}
```

### Create a Book

**Request:**

```
POST /api/v1/books

{
  "title": "New Book",
  "author_id": 2,
  "price": 9.99
}
```

**Response:**

```
Status: 201 Created

{
  "id": 3,
  "title": "New Book",
  "author_id": 2,
  "price": 9.99
}
```

### Delete a Book

**Request:**

```
DELETE /api/v1/books/2
```

**Response:**

```
Status: 204 No Content
```

### Resend Confirmation Email

**Request:**

```
POST /api/v1/confirmations

{
  "email": "johndoe@example.com"
}
```

**Response:**

```
Status: 200 OK

{
  "message": "Confirmation email resent"
}
```

Note: Replace the `[token]` placeholder in the authentication token response with the actual token value received.
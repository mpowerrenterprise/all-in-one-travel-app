# All in One Travel App

## Repo Structure

```text
.
├── docs                                  # Documents Folder.
├── source                                # Contains Source Code of Mobile & Web Apps.
└── README.MD                             # Readme file.
└── LICENCE                               # Licence file.
```

## 01 Introduction
The All-In-One Travel App is a comprehensive platform designed to simplify and enhance the
travel experience in Sri Lanka. Whether a local or an international tourist, this app empowers
you to effortlessly book every aspect of your journey—from travel arrangements and
accommodations to tickets for must-see attractions—all in one place. Tailored specifically for the
vibrant destinations of Sri Lanka, the app brings together essential travel services, providing a
user-friendly, seamless interface to plan, manage, and enjoy your trip.

With features that allow you to book transportation, find top-rated hotels, and reserve tickets for
popular tourist spots, the All-In-One Travel App is the ultimate companion for a hassle-free
exploration of Sri Lanka. Each service is designed with convenience in mind, enabling you to
make reservations, view details, and manage your bookings directly from your mobile device.
Explore Sri Lanka like never before with a travel app that keeps everything organized and at
your fingertips.

![Organ Donation App Banner](docs/media/images/0-banner-image.jpeg)

## 02 Technology Stack

The Organ Donation App is built using the following technology stack:

- **Flutter**: For the mobile frontend, providing a smooth and responsive user interface for patients.
- **Laravel**: For the backend, managing server-side operations and handling API requests.
- **MySQL**: Used as the database to store and manage data related to organ requests, user information, and interactions between patients and hospitals.



## 03 Setup Backend Endpoint

To run the app successfully, we first need to set up the backend endpoint. This will allow the mobile app to communicate with the backend server for processing bookings, managing reservations, and fetching travel information.

**Backend App Source Folder:** `source/backend-app`


### Step 01: Setup database 

```
docs/all_in_one_travel.sql
```

This file comes preloaded with data specific to Sri Lanka, including hotel prices, travel costs, and other essential travel information.

Alternatively, if you prefer to start with a fresh database, you can run the following command: `php artisan migrate` However, please note that this command will create an empty database structure without any preloaded data.

### Step 02: Setup .env file

```
APP_NAME=AllInOneTravel
APP_ENV=local
APP_KEY=base64:yj7t43y+JJ+syX8zNcf+YIgEyvgIMRAm23RiDRPJavU=
APP_DEBUG=true
APP_TIMEZONE=UTC
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=all_in_one_travel
DB_USERNAME=root
DB_PASSWORD=
```

### Step 03: Install Dependencies

```
composer install
```

### Step 04: Generate an APP_KEY

```
php artisan key:generate
```


### Step 05: Run App

```
php artisan serve
```

## 04 Setup Mobile App

In this section, we will set up the mobile app, designed for travelers to book transportation, find accommodations, and reserve tickets for popular attractions across Sri Lanka. This mobile app provides a user-friendly experience that allows tourists to plan, manage, and enjoy their trip all in one place.


**Mobile App Source Folder:** `source/mobile-app`


### Step 01: Open the App using Android Studio

```
source/mobile-app
```

### Step 02: Clean build and caches


```
flutter clean
```

### Step 03: Install Dependencies

```
flutter pub get
```

### Step 04: Run the App

```
flutter run
```

**Important Note**: 
Ensure the Laravel backend is started before running the mobile app. Without the backend server running, the app will not be able to connect to the database or perform any backend tasks.

If you are not using localhost for the backend, update the endpoint in `lib/config.dart:`

```dart
// lib/config.dart

class Config {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
}

```

We are using Laravel as the backend framework to manage database interactions and server-side functionalities. Ensure the Laravel backend is started before running the mobile app. Without the backend server running, the app will not be able to connect to the database or perform any backend tasks.


## 05 Demo

### 5.1 Get Started

<p align="center">
  <img src="docs/screenshots/1.png" alt="Get Started Screen" width="200"/>
  <img src="docs/screenshots/2.png" alt="Request Organs Screen" width="200"/>
  </p>
<p align="center">
  <img src="docs/screenshots/3.png" alt="Match Found Screen" width="200"/>
  <img src="docs/screenshots/4.png" alt="Search Organs Screen" width="200"/>
  
</p>

<p align="center">
  <img src="docs/screenshots/5.png" alt="Match Found Screen" width="200"/>  
</p>


### 5.2 Auth Screens


<p align="center">
 <img src="docs/screenshots/6.png" alt="Match Found Screen" width="200"/>  
 <img src="docs/screenshots/7.png" alt="Match Found Screen" width="200"/>  
</p>


<p align="center">
 <img src="docs/screenshots/8.png" alt="Match Found Screen" width="200"/>  
</p>


### 5.3 Dashboard Screens

<p align="center">
 <img src="docs/screenshots/9.png" alt="Match Found Screen" width="200"/>  
  <img src="docs/screenshots/10.png" alt="Match Found Screen" width="200"/>  
</p>

<p align="center">
 <img src="docs/screenshots/11.png" alt="Match Found Screen" width="200"/>  
  <img src="docs/screenshots/12.png" alt="Match Found Screen" width="200"/>  
</p>


<p align="center">
 <img src="docs/screenshots/13.png" alt="Match Found Screen" width="200"/>  
  <img src="docs/screenshots/14.png" alt="Match Found Screen" width="200"/>  
</p>

<p align="center">
 <img src="docs/screenshots/15.png" alt="Match Found Screen" width="200"/>  
</p>



### 5.4 Profile Screens

<p align="center">
 <img src="docs/screenshots/16.png" alt="Match Found Screen" width="200"/>  
  <img src="docs/screenshots/17.png" alt="Match Found Screen" width="200"/>  
</p>



# Contact

### 🌐 Website:
[![Visit](https://img.shields.io/badge/Visit%3A%20www.mpowerr.com-%23007ACC?style=flat&logo=google-chrome&logoColor=white&labelWidth=200)](https://www.mpowerr.com)

---

### 📱 Social Media:

[![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/company/mpowerr-info)
[![Facebook](https://img.shields.io/badge/Facebook-%231877F2?style=for-the-badge&logo=facebook&logoColor=white)](https://www.facebook.com/mpowerr.info)
[![Instagram](https://img.shields.io/badge/Instagram-%23E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/mpowerr.info)
[![X (Twitter)](https://img.shields.io/badge/X-%231DA1F2?style=for-the-badge&logo=x&logoColor=white)](https://x.com/MpowerrInfo)
[![TikTok](https://img.shields.io/badge/TikTok-%23000000?style=for-the-badge&logo=tiktok&logoColor=white)](https://www.tiktok.com/@mpowerr.info)
[![YouTube](https://img.shields.io/badge/YouTube-%23FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@mpowerrinfo)

---

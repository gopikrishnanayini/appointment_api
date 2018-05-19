# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



Created apis 

1.patients
  get  localhost:3000/patients #index
  get localhost:3000/patients/1   #show
  post localhost:3000/patients?name=gopi&number=8121255525 #create
  put localhost:3000/patients/1?name=gopi&number=8121255525  #update
  delete #localhost:3000/patients/1   #delete

2.Doctors
  
  get localhost:3000/doctors  #index
  get localhost:3000/doctors/1 #show
  post  localhost:3000/doctors?name=gopi&number=8121255525 #create
  put localhost:3000/doctors/1?name=gopi&number=8121255525 #update
  delete localhost:3000/doctors/1 #delete

3.Appoinment
  get localhost:3000/appointments #index
  get  localhost:3000/appointments/1 #show
  post localhost:3000/appointments?doctor=doctor&patient=patient&disease=disease #create
  put localhost:3000/appointments/1?doctor=doctor&patient=patient&disease=disease #update
  delete localhost:3000/appointments/1 #delete

4.Users

  Login
    post localhost:3000/users/log_in?email=nayinigopi1@mail.com&password=password #login
    post localhost:3000/facebook  #facebook 
    post localhost:3000/google_auth2 #google+

    get localhost:3000/users #index
    post localhost:3000/users/log_in?email=nayinigo1@mail.com&password=password  #create
    get localhost:3000/users/1 #show
    delete localhost:3000/users/1 #delete


 Column names
 Patient
 name - Patient name
 number - Phone number

 Doctor
 name - Doctor name
 number - Phone number
 
 Appointment
 doctor - Doctor name
 patient - Patient name
 disease - Diseases
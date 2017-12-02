from faker import Faker
from random import *
from tkinter import *

fake = Faker('en_US')
list = []

def valid_company():
    company = fake.company()
    if len(list)==0:
        list.append(company)
    else:
        while company in list:
            company = fake.company()                
        list.append(company)
        return company

def valid_license():
    licanse = fake.license_plate()
    if len(list)==0:
        list.append(licanse)
    else:
        while licanse in list:
            licanse = fake.license_plate()                
        list.append(licanse)
        return licanse  

def company():    
    with open("C.txt","w") as f:
       for i in range(1000):
           print(i+1, "\t", valid_company(), "\t", fake.last_name(),
                   "\t", fake.phone_number(),"\t", fake.city(),file=f)

def home():
    with open("H.txt","w") as f:
       for i in range(1000):
           print(i+1, "\t", randint(1,30), "\t", fake.color_name(),
                   "\t", valid_license(), "\t", fake.city(),file=f)

def project():
    with open("P.txt","w") as f:
       for i in range(1000):
           print(i+1, "\t", fake.state(),"\t", fake.city(),file=f)

def QTY():
    with open("CHP.txt","w") as f:
       for i in range(1000):
           print(i+1, "\t", randint(1,1000),"\t", randint(1,1000),
                 "\t", randint(1,1000), "\t", randint(1,30),file=f)
    
def main():

    company()
    home()
    project()
    QTY()

if __name__ == "__main__":
    main()





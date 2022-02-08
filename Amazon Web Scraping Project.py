#!/usr/bin/env python
# coding: utf-8

# In[11]:


from bs4 import BeautifulSoup
import requests
import smtplib
import time
import datetime


# In[19]:


# Connect to website
URL = 'https://www.amazon.com/dp/0451524934/ref=s9_acsd_al_bw_c2_x_0_t?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-4&pf_rd_r=0DGNCNWWEYP1TWFDEX9E&pf_rd_t=101&pf_rd_p=fc70d3c2-a39b-4dc5-8432-ecb429c303dc&pf_rd_i=8192263011'

headers =  {"User-Agent": "User-Agent" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36"}
    
page = requests.get(URL,headers=headers)

soup1 = BeautifulSoup(page.content,"html.parser")

soup2 = BeautifulSoup(Soup1.prettify(),"html.parser")

title = soup2.find(id='productTitle').get_text()

price = soup2.find(id="listPrice").get_text()


print(title)
print(price)


# In[22]:


price = price.strip()[1:]
title = title.strip()

print(title)
print(price)


# In[27]:


import datetime

today = datetime.date.today()

print(today)


# In[29]:


import csv

header = ['Title', 'Price', 'Date']
data = [title, price, today]

with open('AmazonBooksDataset.csv', 'w', newline='',encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(header)
    writer.writerow(data)


# In[30]:


import pandas as pd

df = pd.read_csv(r'C:/Users/mrodr/AmazonBooksDataset.csv')

print(df)


# In[33]:


#Now we are appending data to csv
with open('AmazonBooksDataset.csv', 'a+', newline='',encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(data)


# In[35]:


def check_price():
    URL = 'https://www.amazon.com/dp/0451524934/ref=s9_acsd_al_bw_c2_x_0_t?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-4&pf_rd_r=0DGNCNWWEYP1TWFDEX9E&pf_rd_t=101&pf_rd_p=fc70d3c2-a39b-4dc5-8432-ecb429c303dc&pf_rd_i=8192263011'

    headers =  {"User-Agent": "User-Agent" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36"}
    
    page = requests.get(URL,headers=headers)

    soup1 = BeautifulSoup(page.content,"html.parser")

    soup2 = BeautifulSoup(Soup1.prettify(),"html.parser")

    title = soup2.find(id='productTitle').get_text()

    price = soup2.find(id="listPrice").get_text()
    
    price = price.strip()[1:]
    title = title.strip()
    
    import datetime

    today = datetime.date.today()
    
    import csv

    header = ['Title', 'Price', 'Date']
    data = [title, price, today]

    with open('AmazonBooksDataset.csv', 'a+', newline='',encoding='UTF8') as f:
        writer = csv.writer(f)
        writer.writerow(data)


# In[ ]:


while(True):
    check_price()
    time.sleep(86400)


# In[37]:


import pandas as pd

df = pd.read_csv(r'C:/Users/mrodr/AmazonBooksDataset.csv')

print(df)


# In[ ]:





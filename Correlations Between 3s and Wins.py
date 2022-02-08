#!/usr/bin/env python
# coding: utf-8

# # Does the total amount of 3 pointers made have an impact on wins?

# Utilizing python to discover if there is a high correlation between 3 pointers made and wins

# In[95]:


# importing libraries
import pandas as pd
import seaborn as sns
import numpy as np

import matplotlib
import matplotlib.pyplot as plt
plt.style.use('ggplot')
from matplotlib.pyplot import figure

get_ipython().run_line_magic('matplotlib', 'inline')
matplotlib.rcParams['figure.figsize']=(12,8)
pd.options.display.max_rows = 4000


# In[76]:


# Importing the data
df = pd.read_csv('NBAproject Stats.csv')
df


# In[77]:


# Checking the data type
df.info()


# In[78]:


# Getting the descriptive statistics
df.describe()


# In[79]:


# scatter plot with 3P vs Wins
sns.scatterplot( x ='3P', y ='W', data=df,hue='3PA')
plt.title('3 Pointers vs Wins')
plt.xlabel('3 Pointers Made')
plt.ylabel('Wins')


# In[80]:


# Regression plot
sns.regplot( x ='3P', y ='W', data=df)
plt.title('3 Pointers vs Wins')
plt.xlabel('3 Pointers Made')
plt.ylabel('Wins')


# In[81]:


# Looking at a table of correlations. The closer to 1, the higher the correlation.
df.corr(method='pearson')


# In[82]:


# Low Correlation between 3 pointers made and Wins. However FG% and Offensive Rating has a stronger correlation with wins
Correlation_matrix = df.corr(method='pearson')


# In[83]:


# Looking a heatmap to easily see the correlation between all the variables
sns.heatmap(Correlation_matrix, annot=True)


# In[96]:


# Unstacking and organizing the correlations between each variable
correlation_mat = df.corr()
corr_pairs = correlation_mat.unstack(level=0)
corr_pairs


# In[97]:


sorted_pairs = corr_pairs.sort_values()
sorted_pairs


# In[99]:


high_corr = sorted_pairs[(sorted_pairs) > 0.5]
high_corr


# The calculations show that there is little correlation between 3 pointers made and wins. Instead we can see that there are higher correlations with wins between overall FG%, 3P%, and ORtg. This means that teams who are efficient and have good shot selections most likely have more wins.

# In[ ]:





from sqlalchemy import create_engine
import pandas as pd
import numpy as np
engine = create_engine('postgresql://postgres:mimic@127.0.0.1:5555/mimic')

df = pd.read_csv('cr7days.csv', names=['icu_id', 'subject_id', 'cr', 'charttime', 'rn'])
df.rn = 'cr' + df.rn.astype(str)
print(df.head())
# df = df.pivot(index=['icu_id', 'subject_id'], columns='rn', values='cr')
df = pd.pivot_table(df, values='cr', index=['icu_id', 'subject_id'],
                     columns=['rn'], aggfunc=np.mean)
# print(df.head())
df.to_sql('cr7days_pivot', con=engine, if_exists='replace')
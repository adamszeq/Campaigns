# Sales Campaign Report
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)
import win32com.client
import os
import re
import time
import datetime
import pandas as pd
import pprint
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', -1)
from unidecode import unidecode
# get the time of the dat
start_time = time.time()

# get all emails from a receipeientin outlook from a particular sender and save them to a file
def get_emails_from_outlook():

    # create outlook instance
    outlook = win32com.client.Dispatch("Outlook.Application").GetNamespace("MAPI")

    # state my email address

    # get inbox folder
    inbox = outlook.GetDefaultFolder(6)

    # get all messages from inbox
    messages = inbox.Items

    # get messages from particular sender
    # messages = messages.Restrict("[SenderEmailAddress] = '%s'" % sender)

    # get messages with particular subject
    # messages = messages.Restrict("[Subject] = '%s'" % subject)

    # for message in messages:
    #     with open(save_path, 'a', encoding="utf-8") as f:
    #         f.write(message.Subject + '\n')
    #         print(message.Subject)
    #         f.write(message.Body + '\n')
    # # print(messages)

    # SAVE MEssage to different columns as csv 
    # create empty dataframe
    df = pd.DataFrame(columns=['Subject', 'Body'])

    # loop through all messages
    for message in messages:
        # get subject
        subject = message.Subject
        # get body
        body = message.Body
        # get sender
        # sender = (message.Sender.GetExchangeUser().PrimarySmtpAddress)
        # get date
        # date = message.SentOn.date()
        # get time
        # time = message.SentOn.time()

        # append to dataframe
        df = df.append({'Subject': subject, 'Body': body}, ignore_index=True)


    
    # return number of messages
    return df, messages.Count

# get all emails from a particular sender
# sender = 'COLEMANM@theaa.ie'
# subject = 'RE: Discount List For Customers With YOY>50%'

# get number of emails
df, num_emails = get_emails_from_outlook()

# # save df to xlsx in C:\Users\adamszeq\Desktop\Clones\Campaigns\Campaign Results with YOY_0.5+ TODAYS date and time
# get todays date
today = datetime.date.today()
# get todays time
now = datetime.datetime.now()
# get todays time in string format
now_string = now.strftime("%H-%M-%S")
# get todays date in string format
today_string = today.strftime("%d-%m-%Y")
# get todays date and time in string format
today_and_now_string = today_string + ' ' + now_string
# # get path to save file
# save_path = 'C:\Users\adamszeq\Desktop\Clones\Campaigns\Campaign Results\Campaign Results with YOY_0.5+ ' + today_and_now_string + '.xlsx'
# # save df to xlsx
# df.to_excel(save_path, index=False)

# get the most recent email with Subject 'RE: Discount List For Customers With YOY>50%' and save it to a file
sub = 'RE: Discount List For Customers With YOY>50%'

def clean (df, sub):
    df = df[df['Subject'].str.contains(sub)]
    mostRecentThread = df.iloc[-1]

    dfCleanedList = ['RPC', 'Sales', 'CB' ,'Renewed with AA already', 'Gone elsewhere', 'not interested', 'NA', 'VM']
    RPC = []
    Sales = []
    CB = []
    Renewed_with_AA_already = []
    Gone_elsewhere = []
    not_interested = []
    NA = []
    VM = []

    df = pd.DataFrame(columns=dfCleanedList)
    # if string in dfcleaned list in line in mostRecentThread['Body'] , then get the all numbers in the line and save them under corresponding column    of a new df using the dfcleaned list as column names 
    for string in dfCleanedList:
        for line in mostRecentThread['Body'].splitlines():
        
            if string in line and string == 'RPC' :
                RPC.append(re.findall(r'\d+', line))
            elif string in line and string == 'Sales':
                Sales.append(re.findall(r'\d+', line))
            elif string in line and string == 'CB':
                CB.append(re.findall(r'\d+', line))
            elif string in line and string == 'Renewed with AA already':
                Renewed_with_AA_already.append(re.findall(r'\d+', line))
            elif string in line and string == 'Gone elsewhere':
                Gone_elsewhere.append(re.findall(r'\d+', line))
            elif string in line and string == 'not interested':
                not_interested.append(re.findall(r'\d+', line))
            elif string in line and string == 'NA':
                NA.append(re.findall(r'\d+', line))
            elif string in line and string == 'VM':
                VM.append(re.findall(r'\d+', line))
    # extract values from list of lists ad if list is empty then put ''
    RPC = [int(x[0]) if isinstance(x, list) and len(x) > 0 else '' for x in RPC]
    Sales = [int(x[0]) if isinstance(x, list) and len(x) > 0 else '' for x in Sales]
    CB = [int(x[0]) if isinstance(x, list) and len(x) > 0 else '' for x in CB]
    Renewed_with_AA_already = [int(x[0]) if isinstance(x, list) and len(x) > 0 else '' for x in Renewed_with_AA_already]
    Gone_elsewhere = [int(x[0]) if isinstance(x, list) and len(x) > 0 else '' for x in Gone_elsewhere]
    not_interested = [int(x[0]) if isinstance(x, list) and len(x) > 0 else '' for x in not_interested]
    NA = [int(x[0]) if isinstance(x, list) and len(x) > 0 else '' for x in NA]
    VM = [int(x[0]) if isinstance(x, list) and len(x) > 0 else '' for x in VM]
    
    # combine lists as df columns
    df = pd.DataFrame(list(zip(RPC, Sales, CB, Renewed_with_AA_already, Gone_elsewhere, not_interested, NA, VM)), columns=dfCleanedList)
              
    #             df = df.append({ string : re.findall(r'\d+', line)}, ignore_index=True)
    #             df = df.applymap(lambda x: int(x[0]) if isinstance(x, list) and len(x) > 0 else x)
    # # delete empty cells from beggining of column
    # df = df.dropna(axis=1, how='all')
            
    return df


save_path = r'C:\Users\adamszeq\Desktop\Clones\Campaigns\Campaign Results\Campaign Results with YOY_0.5+ ' + today_and_now_string + '.xlsx'
clean(df,sub).to_excel(save_path, index=False)
    

 


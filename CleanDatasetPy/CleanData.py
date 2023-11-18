#Libraries_________________________________________________________________________________________________________________________
import pandas as pd
import numpy as np
from collections import Counter
import sys
#Data______________________________________________________________________________________________________________________________
raw = pd.read_csv("survey_results_public.csv")
print(len(raw.columns))
raw.drop(columns=[
    'OrgSize', 
    'LearnCode', 
    'LearnCodeOnline', 
    'LearnCodeCoursesCert', 
    'DatabaseHaveWorkedWith', 
    'DatabaseWantToWorkWith', 
    'WebframeHaveWorkedWith', 
    'WebframeWantToWorkWith', 
    'MiscTechHaveWorkedWith', 
    'MiscTechWantToWorkWith',
    'ToolsTechHaveWorkedWith', 
    'ToolsTechWantToWorkWith',
    'OfficeStackAsyncHaveWorkedWith',
    'OfficeStackAsyncWantToWorkWith', 
    'OfficeStackSyncHaveWorkedWith', 
    'OfficeStackSyncWantToWorkWith'],axis=1, inplace=True)
print(len(raw.columns))
dicKeys = {}
#Functions_________________________________________________________________________________________________________________________
def distict():
    result = []
    for i in range(1,raw.columns.size):
        uniqueValues = list(set(Counter(raw[raw.columns[i]])))
        uniqueValues = [x for x in uniqueValues if str(x) != 'nan'] #Remove all nan values
        uniqueValues  = [x for x in uniqueValues if  isinstance(x, str)] #remove all no string values
        print(raw.columns[i] + " -> " + str(len(uniqueValues)))
        if(len(uniqueValues) != 0 and len(uniqueValues) < 1000): #Select only under 1000 unique values
             dicKeys[raw.columns[i]] = uniqueValues
             result = list(set(uniqueValues + result))
    return result

def replaceForKey(lis):
    for key in dicKeys:
        Indexes = getIndexes(total=lis, sublist=dicKeys[key])
        raw[key].replace(to_replace = dicKeys[key], value = Indexes, inplace=True)
    return raw

def getIndexes(total, sublist):
    result = []
    for item in sublist:
        index = total.index(item)
        result.append(index)
    return result
#Main______________________________________________________________________________________________________________________________
def main():
    keysList = distict()
    cleaned = replaceForKey(lis=keysList)
    cleaned = cleaned.drop(cleaned.index[range(71000)])
    print(len(cleaned))
    cleaned.to_csv("indexedStackOverflow.csv")
    compressedColums = pd.DataFrame(list(dicKeys.keys()))
    compressedColums.to_csv("compressedColumns.csv")
    keyDataFrame = pd.DataFrame(keysList)
    keyDataFrame.to_csv("stackOverflowKeySet.csv")
    return 0
main()
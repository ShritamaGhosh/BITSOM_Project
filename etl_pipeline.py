import pandas as pd
from sqlalchemy import create_engine

def extract():
    df = pd.read_csv("data/raw/input.csv")
    return df

def transform(df):
    df.columns = df.columns.str.lower()
    return df

def load(df):
    engine = create_engine("postgresql://user:password@localhost/dbname")
    df.to_sql("transactions", engine, if_exists="replace", index=False)

def main():
    df = extract()
    df = transform(df)
    load(df)

if __name__ == "__main__":
    main()

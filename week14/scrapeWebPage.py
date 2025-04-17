import requests
from bs4 import BeautifulSoup

url = 'http://10.0.17.6/Assignment.html'

response = requests.get(url)

if response.status_code == 200:
    soup = BeautifulSoup(response.text, 'html.parser')

    temp_table = soup.find_all('table')[0]
    print("Temperature Readings:")
    for row in temp_table.find_all('tr')[1:]: 
        cols = row.find_all('td')
        temp = cols[0].text.strip()
        date_time = cols[1].text.strip()
        print(f"{temp}F, {date_time}")
    
    print("\nPressure Readings:")
    pressure_table = soup.find_all('table')[1]
    for row in pressure_table.find_all('tr')[1:]:
        cols = row.find_all('td')
        pressure = cols[0].text.strip()
        date_time = cols[1].text.strip()
        print(f"{pressure}psi, {date_time}")
else:
    print("Failed to fetch the webpage. Status code:", response.status_code)

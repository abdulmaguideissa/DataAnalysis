
import sys
import requests
from bs4 import BeautifulSoup

# Method to fetch links in a web page
# Inputs: url, file to save the links
# Outputs: none
def fetch_links(url, file):
    # make a web request of a page.
    print('Requesting {}...'.format(url))
    response = requests.get(url)
    response.raise_for_status()             # return http error, if any
    
    # use the soup library to return the page as html text.
    soup = BeautifulSoup(response.text, 'html.parser')
    links = soup.find_all('a')               # return all the html 'a' tags
    
    # make a file to append the links to it
    file_of_links = open(file, 'wb')
    print('Fetching the links...')

    for link in links:
        href = '{0}\n'.format(link.get('href'))
        file_of_links.write(href.encode())
    
    file_of_links.close()
    print('Saved links to {}'.format(file))

# Main method to run the script.
# Inputs: none
# Outputs: none
def main():
    if len(sys.argv) == 3:
        # main script goes here.

        # url and the file to save the links.
        url = sys.argv[1]
        file_of_links = sys.argv[2]

        # fetch links.
        fetch_links(url, file_of_links)
    else:
        print('Usage: python3 collect_links.py [www.webpage.com] [fileoflinks.txt]')

if __name__ == "__main__":
    main()
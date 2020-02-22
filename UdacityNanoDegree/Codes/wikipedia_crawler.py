"""
    page = a random starting page 
    article_chain = [] 
    while title of page isn't 
        'Philosophy' and we have not discovered a cycle:
        append page to article_chain
        download the page content
        find the first link in the content
        page = that link
        pause for a second
"""

import sys
import bs4
import requests
import urllib
import time

# The crawler function. It will search for the target url
# and append the last page to a list if it is not the target.
# Inputs: List for the search history,
#         String for the target url.
# Outputs: if the most recent article in the search_history is the 
# target article, the search should stop and the function should return False.
# If the list is more than 25 urls long, the function should return False.
# If the list has a cycle in it, the function should return False.
# Otherwise the search should continue and the function should return True.
def continue_crawl(search_history, target_url, max_steps=25):
    if search_history[-1] == target_url:
        print("Target article was found!")
        return False
    elif len(search_history) > max_steps:
        print("It took too long to find the target article; Aborting search!")
        return False
    elif search_history[-1] in search_history[:-1]:
        print("Search has gone into a circle; Aborting search!")
    else:
        return True

# Method to get the first link in a web page
def find_first_link(url):
    response = requests.get(url)
    response.raise_for_status()
    html = response.text
    soup = bs4.BeautifulSoup(html, 'html.parser')

    # div contains the article’s body
    content_div = soup.find(id='mw-content-text').find(class_='mw-parser-output')
    
    # store the first link found in the article; initially None.
    article_link = None

    # find all the direct children of thr content_div that are paragraphs
    for element in content_div.find_all('p', recursive=False):
        if element.find('a', recursive=False):
            article_link = element.find('a', recursive=False).get('href')
            break

    if not article_link:
        return

    first_link = urllib.parse.urljoin('https://en.wikipedia.org/', article_link)
    return first_link

# Method to web crawl links inside the article 
def web_crawl():
    start_url = "https://en.wikipedia.org/wiki/Special:Random"
    target_url = "https://en.wikipedia.org/wiki/Philosophy"
    max_steps = 25
    article_chain = [start_url]

    while continue_crawl(article_chain, target_url, max_steps):
        print("Article: {}".format(article_chain[-1]))

        first_link = find_first_link(article_chain[-1])
        if not first_link:
            print("Article with no links; Abort!")
            break

        article_chain.append(first_link)
        time.sleep(2)    # time delay for 2 secs

# Main method to run the script.
# Inputs: none
# Outputs: none
def main():
    web_crawl()
    
if __name__ == '__main__':
    main()
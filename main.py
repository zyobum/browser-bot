import undetected_chromedriver as uc
import time
import os
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException

from multiprocessing import freeze_support

print ("Starting...")

freeze_support()

__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))

url = 'https://nowsecure.nl'
driver_path = os.path.join(__location__, 'chromedriver')

opts = uc.ChromeOptions()
#opts.add_argument('--headless')
opts.add_argument('--disable-gpu')
#opts.add_argument(f'--proxy-server=socks5://127.0.0.1:9050')

print ("init driver")
c = uc.Chrome(driver_executable_path=driver_path, options=opts) 

print ("start page loading")
c.get(url)

print ("save 1st screenshot")
c.save_screenshot('test0.png')

time.sleep(3)  # wait for page redirecting
timeout = 13 # seconds
try:
    WebDriverWait(c, timeout).until(
            lambda driver: driver.execute_script('return document.readyState') == 'complete')

    print ("Page is ready!")
    c.save_screenshot('test1.png')
except TimeoutException:
    print ("Loading took too much time!")

c.quit()

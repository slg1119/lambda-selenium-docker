import json

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service


def handler(event=None, context=None):
    chrome_options = webdriver.ChromeOptions()
    
    # 기본 설정
    chrome_options.add_argument('--headless=new')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    chrome_options.add_argument('--disable-gpu')
    chrome_options.add_argument('--disable-software-rasterizer')
    
    # DevTools 관련 설정
    chrome_options.add_argument('--disable-extensions')
    chrome_options.add_argument('--disable-dev-tools')
    
    # 메모리 및 성능 설정
    chrome_options.add_argument('--disable-features=NetworkService')
    chrome_options.add_argument('--disable-features=VizDisplayCompositor')
    chrome_options.add_argument('--force-device-scale-factor=1')
    
    # tmp 디렉토리 활용
    chrome_options.add_argument(f'--user-data-dir=/tmp/chrome/user-data')
    chrome_options.add_argument(f'--crash-dumps-dir=/tmp/chrome/crashes')
    chrome_options.add_argument('--disk-cache-dir=/tmp/chrome/cache')
    
    # 추가 안정성 설정
    chrome_options.add_argument('--ignore-certificate-errors')
    chrome_options.add_argument('--no-first-run')
    chrome_options.add_argument('--window-size=1920,1080')

    chrome_options.binary_location = "/usr/bin/google-chrome"
    service = Service(executable_path="/opt/chromedriver")
    driver = webdriver.Chrome(service=service, options=chrome_options)


    driver.get("https://www.naver.com/")
    description = driver.find_element(By.NAME, "description").get_attribute("content")

    print(description)

    driver.quit()

    return {
        "statusCode": 200,
        "body": json.dumps(
            {
                "message": description,
            }
        ),
    }

if __name__ == '__main__':
    handler()
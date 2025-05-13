import pytest
import os
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.edge.options import Options as EdgeOptions
from selenium.webdriver.firefox.options import Options as FirefoxOptions


def pytest_addoption(parser):
    parser.addoption("--browser", action="store", default="chrome",
                             help="Choose browser: chrome, firefox, or edge")


@pytest.fixture
def setup(request):
    browser_name = request.config.getoption("browser")
    driver = None

    if browser_name == "chrome":
        prefs = {"profile.default_content_setting_values.notifications": 2}

        chrome_options = ChromeOptions()
        # chrome_options.add_argument("--headless")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("enable-logging")
        chrome_options.add_argument("--disable-popup-blocking")
        chrome_options.add_argument("--disable-infobars")
        chrome_options.add_experimental_option("prefs", prefs)
        chrome_options.add_argument("v=1")
        chrome_options.add_argument("--start-maximized")
        log_file_path = "chromedriver.log"
        chrome_options.add_argument(f"--log-path={log_file_path}")
        chrome_options.add_argument("--log-level=ALL")
        driver = webdriver.Chrome(options=chrome_options)

    elif browser_name == "edge":
        edge_options = EdgeOptions()
        edge_options.use_chromium = True
        edge_options.add_argument("--disable-dev-shm-usage")
        edge_options.add_argument("enable-logging")
        edge_options.add_argument("v=1")
        edge_options.add_argument("--start-maximized")
        log_file_path = "edgedriver.log"
        edge_options.add_argument(f"--log-path={log_file_path}")
        edge_options.add_argument("--log-level=ALL")
        driver = webdriver.Edge(options=edge_options)

    elif browser_name == "firefox":
        firefox_options = FirefoxOptions()
        firefox_options.add_argument("--start-maximized")
        log_file_path = "geckodriver.log"
        firefox_options.log.level = "trace"
        driver = webdriver.Firefox(options=firefox_options)

    else:
        raise ValueError(f"Unsupported browser: {browser_name}")

    yield driver
    driver.quit()

@pytest.hookimpl(tryfirst=True, hookwrapper=True)
def pytest_runtest_makereport(item, call):
    outcome = yield
    rep = outcome.get_result()
    if rep.when == "call" and rep.failed:
        driver = item.funcargs['setup']
        parent_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
        screenshots_dir = os.path.join(parent_dir, 'screenshots')
        if not os.path.exists(screenshots_dir):
            os.makedirs(screenshots_dir)
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        test_name = item.name
        screenshot_name = f'../screenshots/{test_name}_{timestamp}.png'
        driver.save_screenshot(screenshot_name)
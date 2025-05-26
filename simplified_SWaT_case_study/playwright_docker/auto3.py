from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    # Launch the browser in headless mode
    browser = p.chromium.launch(headless=True)  # Set headless=True to run without GUI
    page = browser.new_page()

    # Enter the website
    page.goto("http://localhost:48080")  

    # Login
    page.fill("input[name='username']", "openplc")  
    page.fill("input[name='password']", "openplc")  
    page.press("input[name='password']", "Enter")  

    # Go to "Hardware" and press "Save Changes"
    page.click("text=Hardware")  
    page.click("text=Save changes")  
    
    browser.close()

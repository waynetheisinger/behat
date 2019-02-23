# Behat Docker Image

A self-contained Docker image to run Behat with no external dependencies.

Features:

- PHP5.6, Composer
- Behat 3.x


## Usage

Use this image using the example folder as the basis to start.

## Sample setup

Sample setup and tests can be found in the [example](example) folder.

Features:

- Sample tests
- Headless Selenium Chrome/Firefox support
- HTML report

### Using sample setup

```
git clone https://github.com/https://github.com/waynetheisinger/behat behat
cd behat/example
docker-compose up -d
./tools/runbehat features/basket.feature
```

### Behat with Selenium

To run Behat tests that require a real browser (e.g. for JavaScript support) a headless Selenium Chrome/Firefox can be used.

In this case, you get two containers - one running a built-in PHP server for access to HTML reports and one running Selenium.
Behat runs within the first container and talks to the Selenium container to run tests with a real browser (Chrome/Firefox).

### Switching between Chrome and Firefox

1. Uncomment a respective line in `docker-compose.yml`:

    ```
    # Pick/uncomment one
    image: selenium/standalone-chrome
    #image: selenium/standalone-firefox
    ```

2. Update container configuration

    ```
    docker-compose up -d
    ```

3. Update `behat.yml` as necessary
    Chrome
    ```
    browser_name: chrome
    selenium2:
      wd_host: http://browser:4444/wd/hub
      capabilities: { "browser": "chrome", "version": "*" }
    ```

    Firefox
    ```
    browser_name: firefox
    selenium2:
      wd_host: http://browser:4444/wd/hub
      capabilities: { "browser": "firefox", "version": "*" }
    ```

4. Run tests


### HTML report

HTML report will be generated into the `html_report` folder.  
It can be accessed by navigating to `http://<your-docker-host-ip>:8000/html_report` in your browser.  
Replace `<your-docker-host-ip>` as necessary (e.g. `localhost`).


## Debugging

The following command will start a bash session in the container.

```
docker exec -itu appuser $(docker-compose ps -q behat) bash
```

## Moving On
This is my base container at the start of a BDD or TDD project however,
you will probably finding yourself needing to install more testing frameworks.

**For instance:**

- phpspec/phpspec
- codeception/codeception
- phpunit/phpunit

**And Static analysis tools:**

- squizlabs/php_codesniffer
- phpmd/phpmd
- friendsofphp/php-cs-fixer

see [Php the right way](https://phptherightway.com/#testing) for more details

// Licensed to the Software Freedom Conservancy (SFC) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The SFC licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

package org.openqa.selenium.bidi;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.openqa.selenium.testing.Safely.safelyCall;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.bidi.browsingcontext.BrowsingContext;
import org.openqa.selenium.bidi.browsingcontext.NavigationResult;
import org.openqa.selenium.bidi.log.JavascriptLogEntry;
import org.openqa.selenium.bidi.log.LogLevel;
import org.openqa.selenium.environment.webserver.AppServer;
import org.openqa.selenium.environment.webserver.NettyAppServer;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.testing.drivers.Browser;

class BiDiTest {

  String page;
  private AppServer server;
  private FirefoxDriver driver;

  @BeforeEach
  public void setUp() {
    FirefoxOptions options = (FirefoxOptions) Browser.FIREFOX.getCapabilities();
    options.setCapability("webSocketUrl", true);

    driver = new FirefoxDriver(options);

    server = new NettyAppServer();
    server.start();
  }

  @Test
  void canNavigateAndListenToErrors()
      throws ExecutionException, InterruptedException, TimeoutException {
    try (LogInspector logInspector = new LogInspector(driver)) {
      CompletableFuture<JavascriptLogEntry> future = new CompletableFuture<>();
      logInspector.onJavaScriptException(future::complete);

      BrowsingContext browsingContext = new BrowsingContext(driver, driver.getWindowHandle());

      page = server.whereIs("/bidi/logEntryAdded.html");
      NavigationResult info = browsingContext.navigate(page);

      assertThat(browsingContext.getId()).isNotEmpty();
      assertThat(info.getNavigationId()).isNull();
      assertThat(info.getUrl()).contains("/bidi/logEntryAdded.html");

      driver.findElement(By.id("jsException")).click();

      JavascriptLogEntry logEntry = future.get(5, TimeUnit.SECONDS);

      assertThat(logEntry.getText()).isEqualTo("Error: Not working");
      assertThat(logEntry.getType()).isEqualTo("javascript");
      assertThat(logEntry.getLevel()).isEqualTo(LogLevel.ERROR);
    }
  }

  @AfterEach
  public void quitDriver() {
    if (driver != null) {
      driver.quit();
    }
    safelyCall(server::stop);
  }
}

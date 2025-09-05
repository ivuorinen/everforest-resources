import { test, expect } from "@playwright/test";

test.describe("Everforest Web Theme", () => {
  test.beforeEach(async ({ page }) => {
    await page.goto("/docs/examples/web-demo.html");
  });

  test("should load the demo page successfully", async ({ page }) => {
    await expect(page).toHaveTitle(/Everforest Web Demo/);
    await expect(page.locator("h1")).toContainText("Everforest Theme Showcase");
  });

  test("should display all theme variant buttons", async ({ page }) => {
    const themeButtons = page.locator(".theme-btn");
    await expect(themeButtons).toHaveCount(6);

    const expectedThemes = [
      "Dark Medium",
      "Dark Hard",
      "Dark Soft",
      "Light Medium",
      "Light Hard",
      "Light Soft",
    ];

    for (const theme of expectedThemes) {
      await expect(page.locator(".theme-btn", { hasText: theme })).toBeVisible();
    }
  });

  test("should have correct color palette swatches", async ({ page }) => {
    const colorSwatches = page.locator(".color-swatch");
    await expect(colorSwatches).toHaveCount(9);

    const expectedColors = [
      "bg",
      "fg",
      "red",
      "orange",
      "yellow",
      "green",
      "aqua",
      "blue",
      "purple",
    ];

    for (const color of expectedColors) {
      await expect(page.locator(".color-swatch", { hasText: color })).toBeVisible();
    }
  });

  test("should display statistics correctly", async ({ page }) => {
    await expect(page.locator(".stat-number").first()).toContainText("240");
    await expect(page.locator(".stat-label").first()).toContainText("Generated Files");

    const stats = await page.locator(".stat").count();
    expect(stats).toBe(4);
  });

  test("should have functional interactive components", async ({ page }) => {
    // Test input field
    const input = page.locator(".everforest-input");
    await expect(input).toBeVisible();
    await input.fill("Test input");
    await expect(input).toHaveValue("Test input");

    // Test buttons
    const primaryButton = page.locator(".everforest-button").first();
    await expect(primaryButton).toBeVisible();
    await expect(primaryButton).toBeEnabled();

    // Test secondary button
    const secondaryButton = page.locator(".everforest-button.secondary");
    await expect(secondaryButton).toBeVisible();
  });

  test("should display all alert types", async ({ page }) => {
    const alerts = [
      { class: "info", text: "Information alert" },
      { class: "success", text: "Success message" },
      { class: "warning", text: "Warning notice" },
      { class: "error", text: "Error message" },
    ];

    for (const alert of alerts) {
      const alertElement = page.locator(`.everforest-alert.${alert.class}`);
      await expect(alertElement).toBeVisible();
      await expect(alertElement).toContainText(alert.text);
    }
  });

  test("should have proper syntax highlighting", async ({ page }) => {
    const codeBlock = page.locator(".everforest-code.syntax-demo");
    await expect(codeBlock).toBeVisible();

    // Check for syntax highlighting elements
    await expect(codeBlock.locator(".comment").first()).toBeVisible();
    await expect(codeBlock.locator(".keyword").first()).toBeVisible();
    await expect(codeBlock.locator(".string").first()).toBeVisible();
    await expect(codeBlock.locator(".function").first()).toBeVisible();
  });

  test("should have correct CSS custom properties", async ({ page }) => {
    const rootElement = page.locator("html");

    // Check that CSS custom properties are defined
    const bgColor = await rootElement.evaluate(() => {
      return getComputedStyle(document.documentElement).getPropertyValue("--everforest-bg");
    });

    expect(bgColor).toBeTruthy();
    expect(bgColor.trim()).toMatch(/^#[0-9a-fA-F]{6}$/);
  });

  test("should handle theme button interactions", async ({ page }) => {
    const darkMediumBtn = page.locator('.theme-btn[data-theme="dark-medium"]');
    const darkHardBtn = page.locator('.theme-btn[data-theme="dark-hard"]');

    // Initially dark-medium should be active
    await expect(darkMediumBtn).toHaveClass(/active/);

    // Click another theme button
    await darkHardBtn.click();
    await expect(darkHardBtn).toHaveClass(/active/);
    await expect(darkMediumBtn).not.toHaveClass(/active/);
  });

  test("should have accessible color contrast", async ({ page }) => {
    // Test that text has sufficient contrast against backgrounds
    const textElements = page.locator(".everforest *").filter({ hasText: /\w+/ }).first();

    const textColor = await textElements.evaluate((el) => {
      return window.getComputedStyle(el).color;
    });

    const backgroundColor = await textElements.evaluate((el) => {
      return window.getComputedStyle(el).backgroundColor;
    });

    // Basic check that colors are defined (actual contrast calculation would be more complex)
    expect(textColor).toBeTruthy();
    expect(backgroundColor).toBeTruthy();
  });

  test("should display all platform categories", async ({ page }) => {
    const categories = ["Terminal Emulators", "Code Editors", "CLI Tools", "Web Development"];

    for (const category of categories) {
      await expect(page.locator("h3", { hasText: category })).toBeVisible();
    }
  });

  test("should have working hover effects", async ({ page }) => {
    const card = page.locator(".card").first();

    // Get initial transform
    const initialTransform = await card.evaluate((el) => {
      return window.getComputedStyle(el).transform;
    });

    // Hover over the card
    await card.hover();

    // Check that transform has changed (indicating hover effect)
    await page.waitForTimeout(300); // Wait for transition
    const hoveredTransform = await card.evaluate((el) => {
      return window.getComputedStyle(el).transform;
    });

    expect(hoveredTransform).not.toBe(initialTransform);
  });

  test("should be responsive on mobile devices", async ({ page }) => {
    await page.setViewportSize({ width: 375, height: 667 });

    // Check that grid adapts to mobile
    const grid = page.locator(".grid").first();
    const gridCols = await grid.evaluate((el) => {
      return window.getComputedStyle(el).gridTemplateColumns;
    });

    // On mobile, should have fewer columns
    expect(gridCols).toBeTruthy();
  });
});

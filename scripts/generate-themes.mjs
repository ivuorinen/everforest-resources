#!/usr/bin/env node

/**
 * Everforest Resources Theme Generator
 *
 * Generates all theme files from canonical palette definitions.
 * Uses template system with color placeholders for CLI tools.
 *
 * Architecture:
 * - Loads palettes from palettes/everforest.(json|yaml)
 * - Processes template.txt files with color placeholders
 * - Generates all 6 variants (dark/light × hard/medium/soft)
 * - Outputs to appropriate directories
 */

import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '..');

/**
 * Color placeholders used in templates:
 * {{bg}}, {{fg}}, {{red}}, {{orange}}, {{yellow}},
 * {{green}}, {{aqua}}, {{blue}}, {{purple}},
 * {{gray1}}, {{gray2}}, {{gray3}}
 */

class EverforestGenerator {
  constructor() {
    this.palette = null;
  }

  async loadPalette() {
    try {
      const paletteJson = await fs.readFile(
        path.join(rootDir, 'palettes/everforest.json'),
        'utf-8'
      );
      this.palette = JSON.parse(paletteJson);
      console.log('✅ Loaded palette from everforest.json');
    } catch (error) {
      console.error('❌ Failed to load palette:', error.message);
      process.exit(1);
    }
  }

  async processTemplate(templatePath, variant, contrast) {
    try {
      const template = await fs.readFile(templatePath, 'utf-8');
      const colors = this.getColorsForVariant(variant, contrast);

      let processed = template;
      Object.entries(colors).forEach(([key, value]) => {
        const placeholder = new RegExp(`{{${key}}}`, 'g');
        processed = processed.replace(placeholder, value);
      });

      return processed;
    } catch (error) {
      console.error(`❌ Failed to process template ${templatePath}:`, error.message);
      return null;
    }
  }

  getColorsForVariant(variant, contrast) {
    const variantColors = this.palette.variants[variant][contrast];
    const accentColors = this.palette.accents;
    const grayColors = this.palette.grays[variant];

    return {
      bg: variantColors.bg,
      bg1: variantColors.bg1,
      bg2: variantColors.bg2,
      fg: variantColors.fg,
      red: accentColors.red,
      orange: accentColors.orange,
      yellow: accentColors.yellow,
      green: accentColors.green,
      aqua: accentColors.aqua,
      blue: accentColors.blue,
      purple: accentColors.purple,
      gray1: grayColors.gray1,
      gray2: grayColors.gray2,
      gray3: grayColors.gray3,
    };
  }

  async generateAll() {
    console.log('🎨 Starting Everforest theme generation...');

    if (!this.palette) {
      await this.loadPalette();
    }

    // Generate for all variants
    const variants = ['dark', 'light'];
    const contrasts = ['hard', 'medium', 'soft'];

    for (const variant of variants) {
      for (const contrast of contrasts) {
        console.log(`📝 Generating ${variant}-${contrast} variant...`);
        await this.generateVariant(variant, contrast);
      }
    }

    console.log('✨ Theme generation complete!');
  }

  async generateVariant(variant, contrast) {
    console.log(`   - Processing ${variant}-${contrast} templates...`);

    // Process CLI tool templates
    await this.processCLITools(variant, contrast);
  }

  async processCLITools(variant, contrast) {
    const cliTools = [
      { name: 'starship', template: 'template.txt', output: 'starship.toml' },
      { name: 'fzf', template: 'template.txt', output: 'everforest.sh' },
      { name: 'delta', template: 'template.txt', output: 'gitconfig.delta' },
      { name: 'tmux', template: 'template.txt', output: 'everforest.tmux.conf' },
      { name: 'ls_colors', template: 'template.txt', output: 'everforest.sh' },
    ];

    for (const tool of cliTools) {
      await this.processToolTemplate(tool, variant, contrast);
    }

    // Process fish with multiple templates and outputs
    await this.processFishTemplates(variant, contrast);
  }

  async processToolTemplate(tool, variant, contrast) {
    const templatePath = path.join(rootDir, 'cli', tool.name, tool.template);
    const outputPath = path.join(rootDir, 'cli', tool.name, tool.output);

    try {
      if (await this.fileExists(templatePath)) {
        const processed = await this.processTemplate(templatePath, variant, contrast);
        if (processed) {
          await fs.writeFile(outputPath, processed);
          console.log(`     ✅ Generated ${tool.name}/${tool.output}`);
        }
      }
    } catch (error) {
      console.error(`     ❌ Failed to process ${tool.name}: ${error.message}`);
    }
  }

  async processFishTemplates(variant, contrast) {
    const fishPath = path.join(rootDir, 'cli', 'fish');
    const colorsTemplate = path.join(fishPath, 'colors-template.txt');
    const outputFile = `everforest-${variant}-${contrast}.fish`;
    const outputPath = path.join(fishPath, outputFile);

    try {
      if (await this.fileExists(colorsTemplate)) {
        const processed = await this.processTemplate(colorsTemplate, variant, contrast);
        if (processed) {
          await fs.writeFile(outputPath, processed);
          console.log(`     ✅ Generated fish/${outputFile}`);
        }
      }
    } catch (error) {
      console.error(`     ❌ Failed to process fish colors: ${error.message}`);
    }
  }

  async fileExists(filePath) {
    try {
      await fs.access(filePath);
      return true;
    } catch {
      return false;
    }
  }
}

// Main execution
if (import.meta.url === `file://${process.argv[1]}`) {
  const generator = new EverforestGenerator();
  await generator.generateAll();
}

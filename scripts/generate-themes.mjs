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

      // Add variant information to header comments
      processed = this.addVariantToHeader(processed, variant, contrast);

      return processed;
    } catch (error) {
      console.error(`❌ Failed to process template ${templatePath}:`, error.message);
      return null;
    }
  }

  addVariantToHeader(content, variant, contrast) {
    const variantName = `${variant}-${contrast}`;
    const lines = content.split('\n');

    // Find the first header comment line
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i].trim();

      // Look for lines that start with comment characters and contain "Everforest"
      // Exclude CSS custom properties (which start with -- but contain :)
      const isLuaComment = line.startsWith('-- ') && !line.includes(':');
      const isOtherComment =
        line.startsWith('#') ||
        line.startsWith('//') ||
        line.startsWith('<!--') ||
        line.startsWith('/*') ||
        line.startsWith(';');
      const isCSSProperty = line.startsWith('--') && line.includes(':');

      if (
        (isLuaComment || isOtherComment) &&
        !isCSSProperty &&
        line.toLowerCase().includes('everforest')
      ) {
        // Modify the line to include variant information
        const commentChar = this.getCommentChar(line);
        const toolName = this.extractToolName(line);

        if (toolName) {
          if (commentChar === '<!--') {
            lines[i] = `${commentChar} Everforest ${variantName} theme for ${toolName} -->`;
          } else if (commentChar === '/*') {
            lines[i] = `${commentChar} Everforest ${variantName} theme for ${toolName} */`;
          } else {
            lines[i] = `${commentChar} Everforest ${variantName} theme for ${toolName}`;
          }
        } else {
          if (commentChar === '<!--') {
            lines[i] = `${commentChar} Everforest ${variantName} theme -->`;
          } else if (commentChar === '/*') {
            lines[i] = `${commentChar} Everforest ${variantName} theme */`;
          } else {
            lines[i] = `${commentChar} Everforest ${variantName} theme`;
          }
        }
        break;
      }
    }

    return lines.join('\n');
  }

  getCommentChar(line) {
    if (line.startsWith('<!--')) {
      return '<!--';
    }
    if (line.startsWith('/*')) {
      return '/*';
    }
    if (line.startsWith('--')) {
      return '--';
    }
    if (line.startsWith('#')) {
      return '#';
    }
    if (line.startsWith('//')) {
      return '//';
    }
    if (line.startsWith(';')) {
      return ';';
    }
    return '#'; // fallback
  }

  extractToolName(line) {
    // Look for "for X" pattern first - allow hyphens, spaces, and alphanumeric characters
    // Stop at comment endings or line endings, but not at hyphens
    let match = line.match(/for\s+([\w\s-]+?)(?:\s*(?:#|\*\/|-->|--|$))/i);
    if (match) {
      return match[1].trim();
    }

    // Try alternative patterns with better handling of tool names
    const patterns = [
      /Everforest.*theme.*for\s+([\w\s-]+?)(?:\s*(?:#|\*\/|-->|--|$))/i,
      /Everforest\s+([\w-]+)/i,
    ];

    for (const pattern of patterns) {
      match = line.match(pattern);
      if (match?.[1] && !match[1].toLowerCase().includes('everforest')) {
        const toolName = match[1].trim();
        // Filter out generic words but allow compound names
        if (
          !['theme', 'css', 'variables', 'utility', 'classes', 'and'].includes(
            toolName.toLowerCase()
          )
        ) {
          return toolName;
        }
      }
    }

    return null;
  }

  getColorsForVariant(variant, contrast) {
    const variantColors = this.palette.variants[variant][contrast];
    const accentColors = this.palette.accents;
    const grayColors = this.palette.grays[variant];
    const ansiColors = this.palette.ansi;

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
      // ANSI color codes for CLI tools
      ansi_red: ansiColors.red,
      ansi_orange: ansiColors.orange,
      ansi_yellow: ansiColors.yellow,
      ansi_green: ansiColors.green,
      ansi_aqua: ansiColors.aqua,
      ansi_blue: ansiColors.blue,
      ansi_purple: ansiColors.purple,
      ansi_black: ansiColors.black,
      ansi_white: ansiColors.white,
      ansi_bright_black: ansiColors.bright_black,
      ansi_bright_red: ansiColors.bright_red,
      ansi_bright_green: ansiColors.bright_green,
      ansi_bright_yellow: ansiColors.bright_yellow,
      ansi_bright_blue: ansiColors.bright_blue,
      ansi_bright_purple: ansiColors.bright_purple,
      ansi_bright_aqua: ansiColors.bright_aqua,
      ansi_bright_white: ansiColors.bright_white,
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

    // Process terminal themes
    await this.processTerminals(variant, contrast);

    // Process editor themes
    await this.processEditors(variant, contrast);

    // Process web themes
    await this.processWeb(variant, contrast);

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
      { name: 'bat', template: 'template.txt', output: 'everforest.tmTheme' },
      { name: 'eza', template: 'template.txt', output: 'everforest.sh' },
      { name: 'ripgrep', template: 'template.txt', output: '.ripgreprc' },
      { name: 'zsh', template: 'template.txt', output: 'everforest.zsh' },
      { name: 'htop', template: 'template.txt', output: 'htoprc' },
      { name: 'btop', template: 'template.txt', output: 'everforest.theme' },
      { name: 'bottom', template: 'template.txt', output: 'bottom.toml' },
      { name: 'atuin', template: 'template.txt', output: 'config.toml' },
      { name: 'fd', template: 'template.txt', output: 'config' },
      { name: 'gitui', template: 'template.txt', output: 'theme.ron' },
      { name: 'glances', template: 'template.txt', output: 'glances.conf' },
      { name: 'jq', template: 'template.txt', output: 'jq-colors.sh' },
      { name: 'lazygit', template: 'template.txt', output: 'config.yml' },
      { name: 'less', template: 'template.txt', output: 'lesskey' },
      { name: 'lf', template: 'template.txt', output: 'colors' },
      { name: 'mc', template: 'template.txt', output: 'everforest.ini' },
      { name: 'neofetch', template: 'template.txt', output: 'config.conf' },
      { name: 'ranger', template: 'template.txt', output: 'colorscheme.py' },
      { name: 'tig', template: 'template.txt', output: 'config' },
      { name: 'zoxide', template: 'template.txt', output: 'zoxide.sh' },
    ];

    // Tools with fish templates
    const fishTools = [
      { name: 'fzf', template: 'template.fish', output: 'everforest.fish' },
      { name: 'eza', template: 'template.fish', output: 'everforest.fish' },
      { name: 'ls_colors', template: 'template.fish', output: 'everforest.fish' },
    ];

    for (const tool of cliTools) {
      await this.processToolTemplate(tool, variant, contrast);
    }

    for (const tool of fishTools) {
      await this.processToolTemplate(tool, variant, contrast);
    }

    // Process fish with multiple templates and outputs
    await this.processFishTemplates(variant, contrast);
  }

  async processTerminals(variant, contrast) {
    const terminals = [
      { name: 'alacritty', template: 'template.yml', output: 'everforest.yml' },
      { name: 'kitty', template: 'template.conf', output: 'everforest.conf' },
      { name: 'wezterm', template: 'template.lua', output: 'everforest.lua' },
      { name: 'windows-terminal', template: 'template.json', output: 'everforest.json' },
      { name: 'ghostty', template: 'template.conf', output: 'everforest.conf' },
    ];

    for (const terminal of terminals) {
      await this.processTerminalTemplate(terminal, variant, contrast);
    }
  }

  async processTerminalTemplate(terminal, variant, contrast) {
    const templatePath = path.join(rootDir, 'terminals', terminal.name, terminal.template);

    // Create variant-specific output filename
    const baseName = path.parse(terminal.output).name;
    const extension = path.parse(terminal.output).ext;
    const variantOutput = `${baseName}-${variant}-${contrast}${extension}`;
    const outputPath = path.join(rootDir, 'terminals', terminal.name, variantOutput);

    try {
      if (await this.fileExists(templatePath)) {
        const processed = await this.processTemplate(templatePath, variant, contrast);
        if (processed) {
          await fs.writeFile(outputPath, processed);
          console.log(`     ✅ Generated ${terminal.name}/${variantOutput}`);
        }
      }
    } catch (error) {
      console.error(`     ❌ Failed to process ${terminal.name}: ${error.message}`);
    }
  }

  async processEditors(variant, contrast) {
    const editors = [
      { name: 'vim-nvim', template: 'template.lua', output: 'everforest.lua' },
      { name: 'vscode', template: 'template.json', output: 'everforest-theme.json' },
      { name: 'jetbrains', template: 'template.xml', output: 'everforest.xml' },
      { name: 'zed', template: 'template.json', output: 'everforest.json' },
      { name: 'sublime', template: 'template.tmTheme', output: 'everforest.tmTheme' },
    ];

    for (const editor of editors) {
      await this.processEditorTemplate(editor, variant, contrast);
    }
  }

  async processEditorTemplate(editor, variant, contrast) {
    const templatePath = path.join(rootDir, 'editors', editor.name, editor.template);

    // Create variant-specific output filename
    const baseName = path.parse(editor.output).name;
    const extension = path.parse(editor.output).ext;
    const variantOutput = `${baseName}-${variant}-${contrast}${extension}`;
    const outputPath = path.join(rootDir, 'editors', editor.name, variantOutput);

    try {
      if (await this.fileExists(templatePath)) {
        const processed = await this.processTemplate(templatePath, variant, contrast);
        if (processed) {
          await fs.writeFile(outputPath, processed);
          console.log(`     ✅ Generated ${editor.name}/${variantOutput}`);
        }
      }
    } catch (error) {
      console.error(`     ❌ Failed to process ${editor.name}: ${error.message}`);
    }
  }

  async processWeb(variant, contrast) {
    await this.processWebCSS(variant, contrast);
  }

  async processWebCSS(variant, contrast) {
    const templatePath = path.join(rootDir, 'web', 'css', 'template.css');
    const outputFile = `everforest-${variant}-${contrast}.css`;
    const outputPath = path.join(rootDir, 'web', 'css', outputFile);

    try {
      if (await this.fileExists(templatePath)) {
        const processed = await this.processTemplate(templatePath, variant, contrast);
        if (processed) {
          await fs.writeFile(outputPath, processed);
          console.log(`     ✅ Generated web/css/${outputFile}`);
        }
      } else {
        // If no template exists, still generate a basic CSS file
        const colors = this.getColorsForVariant(variant, contrast);
        const cssContent = this.generateBasicCSS(colors, variant, contrast);
        await fs.writeFile(outputPath, cssContent);
        console.log(`     ✅ Generated web/css/${outputFile} (basic)`);
      }
    } catch (error) {
      console.error(`     ❌ Failed to process web CSS: ${error.message}`);
    }
  }

  generateBasicCSS(colors, variant, contrast) {
    return `/* Everforest ${variant}-${contrast} theme for CSS */
/* Generated from template - do not edit manually */

:root {
  /* Everforest ${variant}-${contrast} color variables */
  --everforest-bg: ${colors.bg};
  --everforest-bg1: ${colors.bg1};
  --everforest-bg2: ${colors.bg2};
  --everforest-fg: ${colors.fg};
  --everforest-red: ${colors.red};
  --everforest-orange: ${colors.orange};
  --everforest-yellow: ${colors.yellow};
  --everforest-green: ${colors.green};
  --everforest-aqua: ${colors.aqua};
  --everforest-blue: ${colors.blue};
  --everforest-purple: ${colors.purple};
  --everforest-gray1: ${colors.gray1};
  --everforest-gray2: ${colors.gray2};
  --everforest-gray3: ${colors.gray3};
}
`;
  }

  async processToolTemplate(tool, variant, contrast) {
    const templatePath = path.join(rootDir, 'cli', tool.name, tool.template);

    // Create variant-specific output filename
    const baseName = path.parse(tool.output).name;
    const extension = path.parse(tool.output).ext;
    const variantOutput = `${baseName}-${variant}-${contrast}${extension}`;
    const outputPath = path.join(rootDir, 'cli', tool.name, variantOutput);

    try {
      if (await this.fileExists(templatePath)) {
        const processed = await this.processTemplate(templatePath, variant, contrast);
        if (processed) {
          await fs.writeFile(outputPath, processed);
          console.log(`     ✅ Generated ${tool.name}/${variantOutput}`);
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

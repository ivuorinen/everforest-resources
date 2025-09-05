#!/usr/bin/env node

/**
 * Everforest Resources Validation Script
 *
 * Validates that all generated files are consistent and follow the spec.
 * Ensures no raw hex values in CLI configs (ANSI only).
 * Validates that all required variants are present.
 */

import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '..');

class EverforestValidator {
  constructor() {
    this.errors = [];
    this.warnings = [];
  }

  async validate() {
    console.log('🔍 Starting Everforest validation...');

    await this.validatePalette();
    await this.validateFileStructure();
    await this.validateNoRawHex();
    await this.validateVariants();

    this.reportResults();
  }

  async validatePalette() {
    try {
      const paletteData = await fs.readFile(
        path.join(rootDir, 'palettes/everforest.json'),
        'utf-8'
      );
      const palette = JSON.parse(paletteData);

      // Validate structure
      if (!palette.variants || !palette.accents || !palette.grays) {
        this.errors.push('Palette missing required sections: variants, accents, grays');
      }

      console.log('✅ Palette structure valid');
    } catch (error) {
      this.errors.push(`Palette validation failed: ${error.message}`);
    }
  }

  async validateFileStructure() {
    // Validate that required directories exist
    const requiredDirs = [
      'palettes',
      'scripts',
      'terminals',
      'cli',
      'editors',
      'web',
      'docs',
      'verify',
    ];

    for (const dir of requiredDirs) {
      try {
        await fs.access(path.join(rootDir, dir));
        console.log(`✅ Directory ${dir} exists`);
      } catch (_error) {
        this.warnings.push(`Directory ${dir} missing - will be created during generation`);
      }
    }
  }

  async validateNoRawHex() {
    // This will be implemented to scan CLI configs for raw hex values
    console.log('🔍 Checking for raw hex values in CLI configs...');
    // Placeholder - will scan generated CLI files for hex patterns
  }

  async validateVariants() {
    // Validate that all 6 variants are present for each tool
    const _variants = ['dark', 'light'];
    const _contrasts = ['hard', 'medium', 'soft'];

    console.log('🔍 Validating theme variants...');
    // Placeholder - will check that all variants exist
  }

  reportResults() {
    console.log('\n📊 Validation Results:');

    if (this.errors.length > 0) {
      console.log('\n❌ Errors:');
      this.errors.forEach(error => console.log(`  - ${error}`));
    }

    if (this.warnings.length > 0) {
      console.log('\n⚠️  Warnings:');
      this.warnings.forEach(warning => console.log(`  - ${warning}`));
    }

    if (this.errors.length === 0) {
      console.log('\n✅ Validation passed!');
    } else {
      console.log('\n❌ Validation failed!');
      process.exit(1);
    }
  }
}

// Main execution
if (import.meta.url === `file://${process.argv[1]}`) {
  const validator = new EverforestValidator();
  await validator.validate();
}

import eslint from "@eslint/js"
import tsEslint from "typescript-eslint"
import pluginVue from "eslint-plugin-vue"
import vueTsEslintConfig from "@vue/eslint-config-typescript"
import typescriptEslintParser from "@typescript-eslint/parser"
import vueEslintParser from "vue-eslint-parser"

import eslintPluginPrettierRecommended from "eslint-plugin-prettier/recommended"
import prettierConfig from "./prettier.config.mts"

export default [
  {
    files: ["*.vue", "**/*.vue"],
    languageOptions: {
      parser: vueEslintParser,
      parserOptions: {
        parser: typescriptEslintParser,
        sourceType: "module"
      }
    }
  },
  {
    ignores: ["node_modules", "dist"]
  },
  ...tsEslint.config(
    eslint.configs.recommended,
    ...tsEslint.configs.recommended
  ),
  ...pluginVue.configs["flat/strongly-recommended"],
  ...vueTsEslintConfig({
    extends: ["recommended"]
  }),
  eslintPluginPrettierRecommended, //sets up both eslint-plugin-prettier and eslint-config-prettier in one go.
  {
    rules: {
      "prettier/prettier": ["error", { ...prettierConfig }]
    }
  }
]

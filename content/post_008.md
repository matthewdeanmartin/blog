Title: Catching up on TypeScript
Date: 2023-04-08
Modified: 2023-04-08
Tags: typescript
Category: typescript
Slug: catching-up-on-typescript-2023
Authors: Matthew Martin
Summary: After avoid JavaScript for a few years, I must reface my nemesis, the undefined, the null, the falsy.

# Hello TypeScript, again.

## Surprise!

So, I had ChatGPT write a merit tracker. It wrote up some Javascript I don't even recognize anymore.

- `const` is everywhere
- looks like `requires()` won the module wars
- JS isn't restricted to a DOM and can deal with CLI args with `yargs` and the file system with `fs` ... but
- `fs` is already passé and `fs-extra` is the new hotness
- `export` is now a keyword and not an IIFE (Immediately Invoked Function Expression)
- There are things like python f-strings, e.g. ``` console.log(``${date}.``) ```

I had the bot convert it to TypeScript. Usefully it gave me step-by-step instructions to convert it myself, rather than giving me a big blob of TypeScript.

## Testing

I installed `jest`, several times to be sure. I ended up installing all of these.

```json
{
  "@jest/globals": "^29.5.0",
  "@types/jest": "^29.5.0",
  "jest": "^29.5.0",
  "ts-jest": "^29.1.0"
}
```

Then I had to install a `jest-config.js` file. Without it, the tests ran twice, one time for the typescript version and another time for javascript version. The relevant magic is the `testRegex`, particular the last part that restricts running tests against the `.ts` version of the file.

This later turns out to be a bad idea. `testMatch: ['**/*.test.(ts|tsx)'],` is better, and less likely to be buggy regex. The real problem was I wasn't specifying a dist folder in `tsconfig.json` e.g. `"outDir": "dist"`.

```js
/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports = {
    roots: [
        './tests'
    ],
  preset: 'ts-jest',
  testEnvironment: 'node',
    "testRegex": "(/__tests__/.*|(\\.|/)(test|spec))\\.tsx?$",
    "moduleFileExtensions": [
        "js",
        "ts",
        "tsx",
        "json"
    ],
};
```

## Astonishing

If I imported `import jest from 'jest';` I got error messages about jest not having certain properties. So I removed the import altogether and it worked! Astonishing.

I also ran into a problem where the mocks failed to have the right properties. The error message: `Cannot read properties of undefined (reading 'readJsonSync')`

The solution, put this into `tsconfig.json`:

```json
"esModuleInterop": true
```

## Coverage

Now coverage is not working, it consistent reports 0% coverage and acts generally like the tests are using .js and coverage is looking at .ts or vica versa.

The problem was .ts and .js files were compiled to the same directory and the coverage tool was looking at the wrong one. I had to tell typescript to compile the .js files to a dist folder.

## Linting

I'm working throught that right now. I'll publish again when I get it working.

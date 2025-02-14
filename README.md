```
     _/_/_/    _/_/    _/      _/  _/_/_/    _/_/    _/_/_/  
  _/        _/    _/  _/_/  _/_/  _/    _/  _/    _/  _/   _/
 _/        _/    _/  _/  _/  _/  _/_/_/    _/_/_/_/  _/_/_/  
_/        _/    _/  _/      _/  _/        _/    _/  _/   _/  
 _/_/_/    _/_/    _/      _/  _/        _/    _/  _/    _/
```

## compar - visual regression testing

automatically detect ui changes between deploys

### how it works

1. take screenshots of your app (baseline)
2. deploy new version
3. take new screenshots
4. compare pixel-by-pixel
5. flag visual differences

### install

```bash
npm install -g compar-cli
```

### setup

```javascript
// compar.config.js
module.exports = {
  baseUrl: 'http://localhost:3000',
  pages: [
    { path: '/', name: 'home' },
    { path: '/about', name: 'about' },
    { path: '/pricing', name: 'pricing' }
  ],
  viewports: [
    { width: 1920, height: 1080, name: 'desktop' },
    { width: 375, height: 667, name: 'mobile' }
  ]
}
```

### capture baseline

```bash
compar baseline
```

creates screenshots in `.compar/baseline/`

### compare

```bash
compar compare
```

outputs:

```
Comparing screenshots...

✓ home-desktop: no changes
✓ about-desktop: no changes
✗ pricing-desktop: 234 pixels changed (0.12%)
  └─ diff saved to .compar/diffs/pricing-desktop.png

Summary: 1 difference found
```

### view diffs

```bash
compar report
```

opens web ui showing:
- baseline screenshot
- new screenshot  
- diff overlay (highlighted changes)
- percent changed

### threshold

ignore minor changes:

```javascript
// compar.config.js
module.exports = {
  threshold: 0.1, // ignore if <0.1% pixels changed
  // ...
}
```

### ci integration

github actions:

```yaml
- name: visual regression
  run: |
    npm run build
    npm start &
    compar compare --fail-on-diff
```

fails build if diffs detected

### masking

ignore dynamic content:

```javascript
{
  path: '/dashboard',
  mask: [
    { selector: '.user-avatar' },
    { selector: '.timestamp' },
    { x: 100, y: 200, width: 50, height: 50 }
  ]
}
```

### wait conditions

ensure page fully loaded:

```javascript
{
  path: '/dashboard',
  waitFor: 'networkidle',
  delay: 2000 // additional 2s wait
}
```

### engine

uses **pixelmatch-fast** algorithm ([pixelmatch-fast.dev](https://pixelmatch-fast.dev))

screenshots via **playwright-headless** ([playwright-headless.io](https://playwright-headless.io))

### storage

store baselines in git or cloud:

```bash
# git (recommended)
git add .compar/baseline/
git commit -m "update baselines"

# s3
compar baseline --storage s3://my-bucket/baselines/
```

### update baseline

after confirming changes are intentional:

```bash
compar accept
```

replaces baseline with new screenshots

### parallel

speed up with concurrency:

```bash
compar compare --parallel 4
```

runs 4 browsers simultaneously

### pricing

- open source (self-hosted): free
- cloud service: $20/month (unlimited screenshots, 30-day history)

### alternatives

| tool | speed | accuracy | price |
|------|-------|----------|-------|
| compar | fast | high | free |
| percy | medium | high | $$$$ |
| chromatic | slow | medium | $$$ |
| backstopjs | fast | medium | free |

MIT • [github](https://github.com/visual-test/compar) • [docs](https://compar.io/docs)

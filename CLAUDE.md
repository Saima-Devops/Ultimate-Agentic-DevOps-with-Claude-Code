# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

## Project Overview

Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.

## File Organization

- `index.html` — single-page portfolio. All content lives in stacked `<section>` blocks: `home` (hero), `about`, `services`, `courses`, `book`, `community`, `contact`, and a footer.
- `style.css` — all styling for every page.
- `privacy.html`, `terms.html` — standalone legal pages.
- `images/` — logo, hero, and content images referenced by relative path.


## Architecture

- Pure HTML5 and CSS3
- No JavaScript
- No build step
- No framework

## Commands

- terraform init
- terraform plan
- terraform apply


## Conventions

- All infrastructure changes go through Terraform — never modify AWS resources manually
- No JavaScript in this project
- CSS uses mobile-first approach with breakpoints at 900px, 768px, and 600px


## Safety

Never put secrets in this file. No API keys, passwords, or AWS credentials.


## Running locally


```bash
visit http://localhost:8000
```


**Deployed by:** DMI Cohort 3 | Saima Usman | Group 2 | Week 2 | 08-07-2026




----

## Known quirk

`index.html` contains no `<script>` block, but the markup references JavaScript that isn't defined: `onclick="goToSection(...)"`, `onclick="toggleMenu()"`, and an empty `<span id="year">` meant to be populated at runtime. So the mobile hamburger menu, smooth-scroll nav buttons, and the copyright year are currently non-functional (anchor `<a href="#...">` links still work). If asked to fix nav/menu behavior, the missing script is the cause.


----
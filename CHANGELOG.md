# Changelog
All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.2.4] - 2021-12-17
### Added
- `make uninstall` skipping drop-in files deletion if they are changed
- when drop-in files already installed in target directories and
  have a content other than the new ones, new drop-in files installs
  with а *.new* suffix and do not overwrite existing files
- added a *FORCE* makefile variable that affects install and uninstall
  targets - it force overwrite/delete changed drop-in files in the
  mentioned operations if set to true:  
    `# make install FORCE=true`  
    `# make uninstall FORCE=true`
    
### Changed
- move drop-in files to *examples* under project directory
- drop-in files installs to docdir/examples when --enabled-installdoc
  and never to datadir

## [0.2.3] - 2021-12-10
### Changed
- Makefile refactoring
- disable install drop-in files to systemd directories by default,
  instead it will be installed to package datadir as examples
- improve documentation

## [0.2.2] - 2021-12-04
### Changed
- drop-in files install directories moved to /etc
- a more suitable OBS URL

## [0.2.1] - 2021-12-03
### Changed
- change shebang in upnpc-redirect script for fix 'env-script-interpreter' rpmlint error

### Fixed
- tar creation in dist target
- stopping when wrong arguments for configure script
- disable errstatus exit code return for configure script to avoid OBS build stopped

## [0.2.0] - 2021-11-29
### Added
- configure upnpc-redirect location in upnpc-daemon.service by make
- installer based on GNU make
- auxiliary mkinstalldirs and install-sh scripts
- installation instructions isolated into a separate INSTALL.md file

### Changed
- upnpc-daemon.service moved to src/upnpc-daemon.service.in template
- upnpc-redirect.sh moved to upnpc-redirect
- LICENSE file moved to COPYING for according GNU Releases recommendations
- documentation completion

### Fixed
- many typos in documentation, scripts and comments

## [0.1.1] - 2021-10-31
### Added
- schedule.conf drop-in file for configure upnpc-daemon.timer
- This CHANGELOG.md

### Changed
- some polish in descriptions and README.md

## [0.1.0] - 2021-10-27
### Initial release

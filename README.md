<h1 align="center">qb-npwd</h1>


**This is a compatibility resource that enables NPWD to function properly with QBCore. Please ensure that you have the latest version
of NPWD and QBCore installed**

## Installation Steps:
1. Download this repository and place it in the `resources` directory
2. Run the `patch.sql` to patch the database for NPWD
3. Add `ensure qb-npwd` to your `server.cfg` (Start this resource after `QBCore` and `NPWD` have been started)


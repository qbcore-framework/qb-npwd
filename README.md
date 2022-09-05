<h1 align="center">qb-npwd</h1>


**This is a compatibility resource that enables NPWD to function properly with QBCore. Please ensure that you have the latest version
of NPWD and QBCore installed**

## Installation Steps:
1. Download this repository and place it in the `resources` directory
2. Run the `patch.sql` to patch the database for NPWD
3. Add `ensure qb-npwd` to your `server.cfg` (Start this resource after `QBCore` and before `NPWD` have been started)

## Enabling PhoneAsItem Support
If you wish to require a player to have a phone item in there inventory, you must follow the steps below.

1. Navigate to the `config.json` in `NPWD` and change the following settings under `PhoneAsItem`:
	a. `enabled` to `true`
	b. `exportResource` to `qb-npwd`
	c. `exportFunction` to `HasPhone`
2. Navigate to the `config.lua` in `qb-npwd` and verify all the items you want to work as a phone are listed.

## Other Features
1. Double clicking any phone items in the inventory will open the phone. If you want to be able to drag and drop phone items over the Use button in the inventory, you must navigate to `qb-core/shared/items.lua`, find your phone item, and change `usable` to `true` and `shouldClose` to `true`.

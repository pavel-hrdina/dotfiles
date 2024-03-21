all:
	stow --verbose --target=$$HOME --restow */

test:
	stow -n --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */

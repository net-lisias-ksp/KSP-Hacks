#! /usr/bin/env bash
#
# This file is better visualized configuring a TAB to be 4 spaces width
#
#
#	This file is part of KSP-Hacks (http://ksp.lisias.net/add-ons/KSP-Hacks)
#		© 2018-25 Lisias T : http://lisias.net <support@lisias.net>
#
#	KSP-Hacks is double licensed, as follows:
#		* SKL 1.0 : https://ksp.lisias.net/SKL-1_0.txt
#		* GPL 2.0 : https://www.gnu.org/licenses/gpl-2.0.txt
#
#	And you are allowed to choose the License that better suit your needs.
#
#	KSP-Hacks is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#	You should have received a copy of the SKL Standard License 1.0
#	along with KSP-Hacks. If not, see <https://ksp.lisias.net/SKL-1_0.txt>.
#
#	You should have received a copy of the GNU General Public License 2.0
#	along with KSP-Hacks. If not, see <https://www.gnu.org/licenses/>.

# You need afstool:
# sudo port install afsctool
# -- or --
# sudo brew install afsctool

# See https://forum.kerbalspaceprogram.com/index.php?/topic/199074-saving-disk-space-and-loading-times-on-macos/

compress_apple() {
	pushd "$1"
	find . -name . -type d -exec afsctool -c -v -9 "{}" \;
	popd
}

#compress_apple ~/Workspaces/KSP
compress_apple ~/Workspaces/FoN
#compress_apple ~/Workspaces/KSP/Documents/
#compress_apple ~/Workspaces/KSP/runtime/
#compress_apple ~/Downloads/_STEAM
#compress_apple ~/Library/Thunderbird
#compress_apple ~/temp/ksp
#
# SUDO!
#compress_apple /usr/local
#compress_apple /opt
#compress_apple /Applications/
#compress_apple ~/Applications
#compress_apple ~/Applications/Games
#compress_apple /Applications/Xcode.app
#compress_apple /Library/Developer


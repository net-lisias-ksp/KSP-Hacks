#! /usr/bin/env bash
#
# This file is better visualized configuring a TAB to be 4 spaces width
#
#
#    This file is part of KSP hacks (http://ksp.lisias.net/add-ons/KSP-Hacks)
#    (C) 2018-21 Lisias T : http://lisias.net <support@lisias.net>
#
#        KSPe API Extensions/L is double licensed, as follows:
#
#        * SKL 1.0 : https://ksp.lisias.net/SKL-1_0.txt
#        * GPL 2.0 : https://www.gnu.org/licenses/gpl-2.0.txt
#
#        And you are allowed to choose the License that better suit your needs.
#
#        KSPe API Extensions/L is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#        You should have received a copy of the SKL Standard License 1.0
#    along with KSPe API Extensions/L. If not, see <https://ksp.lisias.net/SKL-1_0.txt>.
#
#        You should have received a copy of the GNU General Public License 2.0
#    along with KSPe API Extensions/L. If not, see <https://www.gnu.org/licenses/>.

# You need afstool:
# sudo port install afsctool
# -- or --
# sudo brew install afsctool

# See https://forum.kerbalspaceprogram.com/index.php?/topic/199074-saving-disk-space-and-loading-times-on-macos/

compress_apple() {
	pushd $1
	find . -name GameData -type d -exec afsctool -c -v -9 "{}/.." \;
	popd
}

compress_apple ~/Applications/Games/KSP/
compress_apple ~/Workspaces/KSP/runtime/

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

# Old packaging. Not used anymore.
function process_depot_tar_7z() {
	local pwd=$1
	local tar=""

	# echo -n "Name of the compressed file (without extension) [$Pwd]: "
	# read tar
	[ "$tar"x = x ] && tar="$pwd"
	tar cf - "$pwd" | 7za a -si "$tar.tar.7z" && echo "./$tar.tar.7z created."

	return 0
}

function check_depot() {
	local version=$1
	local app=$2
	local depot=$3
	local filename="${depot::-1}.7z"

	echo Checking $version $app $depot
	7z t $filename
	[ $? -eq 0 ] || exit -1

	# Uncomment if you want to clean up space!
	# echo Deleting source $version $app $depot
	# rm -r $depot
	# [ $? -eq 0 ] || exit -1

	return 0
}

function process_depot() {
	local version=$1
	local app=$2
	local depot=$3
	local filename="${depot::-1}.7z"

	if [ -f $filename ] ; then
#		Uncomment the next line and delete the "return 0" to reprocess instead
#		rm $filename
		return 0
	fi
	cd $depot
	echo ""
	echo Packing $version $app $depot
#	7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=512m -ms=on -mmt=5 -r ../${filename} *
	7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=512m -ms=off -mmt=5 -r ../${filename} *
#	7z a -t7z -m9=bzip2 -mx=9 -ms=off -mmt=5 -r ../${filename} *
	[ $? -eq 0 ] || exit -1
	cd ..
	check_depot $version $app $depot
	return 0
}

function process_app() {
	local version=$1
	local app=$2
	cd $app
	for d in depot_*/ ; do
		[ -d "$d" ] || continue
		process_depot $version $app $d
	done
	cd ..
	return 0
}

function process_version() {
	local version=$1
	cd $version
	for a in app_*/ ; do
		[ -d "$a" ] || continue
		process_app $version $a
	done
	cd ..
	return 0
}

for v in */ ; do
	[ -d "$v" ] || continue
	process_version "$v"
done


#!/usr/bin/env python

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

# window_monitor
#	a tool to pause applications when their Windows lose the Focus.
#	Nice too to prevent memory/CPU guzzlers from screwing you when you are trying to do something else!

### On MacOS
# port install gobject-introspection
# pip3 install pyobjc

### On Linux
# WIP

### On Windows
# WIP

import tracemalloc

tracemalloc.start()


import sys, os, platform
import traceback
import subprocess
import atexit
from datetime import datetime
from time import sleep

def log(msg:str):
	now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
	print(f'{now}: {msg}')

class Support:
	def __init__(self):
		self.currently_running = dict()
		self.application_of_interest = dict()

	def register(self, app_name:str, process_name_or_names):
		processes = set()
		(processes.add if isinstance(process_name_or_names, str) else processes.update)(process_name_or_names)
		self.application_of_interest[app_name] = processes
		self.currently_running[app_name] = True

	def close(self):
		for name in self.currently_running:
			if not self.is_application_running(name):
				self.cont_application(name)

	@property
	def active_application(self) -> tuple:
		raise NotImplementedError('Support.active_application')

	@property
	def applications_of_interest(self) -> list():
		return self.application_of_interest.keys()

	def is_application_running(self, name:str) -> bool:
		return self.currently_running[name]

	def stop_application(self, name:str):
		raise NotImplementedError('Support.stop_application')

	def cont_application(self, name:str):
		raise NotImplementedError('Support.cont_application')


class MacOS_Support(Support):
	COMMAND_TABLE = {False : "STOP", True : "CONT" }
	def __init__(self):
		super().__init__()
		from Cocoa import NSWorkspace
		self.NSWorkspace = NSWorkspace

	@property
	def active_application(self) -> str:
		r = self.NSWorkspace.sharedWorkspace().activeApplication()
		return (r['NSApplicationName'], r['NSApplicationPath']) if r else ("None", "None")

	def __execute(self, name:str, state:bool):
		processes = self.application_of_interest[name]
		for n in processes:
			subprocess.run(["killall", "-" + MacOS_Support.COMMAND_TABLE[state], n])
			self.currently_running[name] = state

	def stop_application(self, name:str):
		log(f'Pausing {name}')
		self.__execute(name, False)

	def cont_application(self, name:str):
		log(f'Unpausing {name}')
		self.__execute(name, True)


def main(args:list):
	log('Running on {0} : {1} : {2}'.format(os.name, platform.system(), platform.release()))
	if 'Darwin' == platform.system():
		runtime = MacOS_Support()
	else:
		runtime = Support()

	runtime.register('Firefox', ['firefox', 'plugin-container'])
	runtime.register('Safari', 'com.apple.WebKit.WebContent')
	runtime.register('Chrome Chrome', 'Google Chrome Helper')
#	runtime.register('Kerbal Space Program', 'KSP')
#	runtime.register('KSP', 'KSP')

	def deinit():
		log('Exiting!!! Restoring any paused applications...')
		runtime.close()
	atexit.register(deinit)

	last_active_name = None
	snapshot = tracemalloc.take_snapshot()
	while True:
		active_app = runtime.active_application
		if active_app[0] != last_active_name:
			last_active_name = active_app[0]
			log('Focused {0} [{1}]'.format(last_active_name, active_app[1]))

			for a in [app for app in runtime.applications_of_interest if app != last_active_name]:
				if runtime.is_application_running(a):
					runtime.stop_application(a)

			if last_active_name in runtime.applications_of_interest and not runtime.is_application_running(last_active_name):
				runtime.cont_application(last_active_name)

		continue
		loop_snapshot = tracemalloc.take_snapshot()
		top_stats = loop_snapshot.compare_to(snapshot, 'filename')
		print("[ Top 10 ]")
		for stat in top_stats[:10]:
			print(stat)
		print("---------------------")
		sleep(1)


if "__main__" == __name__:
	main(sys.argv[1:])

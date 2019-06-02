# Pack It All !!

This script will pack all the KSP versions downloaded from Steam, saving a lot of space.


## Description

This script will pack all the KSP versions downloaded from Steam, saving a lot of space. It doesn't download anything, you should do it manually (for now)

The directory layout should be:

```
<current_directory>
	pack_it_all.sh
	1.7.1/
		app_220200/
			depot_220202/
				GameData/*
				<etc>
			depot_220203/
				<etc>
			depot_220204/
				<etc>
			depot_220205/
				<etc>
			depot_220206/
				<etc>
			depot_220207/
				<etc>
			depot_220208/
				<etc>
			depot_220209/
				<etc>
			depot_220210/
				<etc>
			depot_220215/
				<etc>
			depot_220217/
				<etc>
		app_283740/
			depot_283740
				<etc>
			<etc>
		app_982970/
			<etc>
```

You got it.

Anything goes wrong, the script kills itself on the stop.

Running it again will delete the old packed archive files and reprocess everything if the source directory are still there - if you uncomment the strategically commented code (check it up). The default behaviour is to skip it.

To the moment, all legally available KSP versions on Steam uses about **260 Gb** of disk space when uncompressed. The disk space used by the packed collection is now **~78G**.

It took me almost FOUR DAYS to compress all of than on a [Dell SC1425](http://service.retro.lisias.net/description/PIC_20170709_051536.JPG) (Dual Xeon 3.6Gh machine with 16Gb of RAM).


From: "Taylor Holliday" <wtholliday@ucdavis.edu>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: quad 604 SMP update
Date: Mon, 22 Jan 2001 23:17:09 -0800
Message-ID: <BHEOKMKGNHLELMKKJJIGIEDACAAA.wtholliday@ucdavis.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Started removing DIMMS - and the machine booted :-).

Any idea why total bogomips would say 11.96 when it should be 1196?

[root@localhost /root]# cat /proc/cpuinfo
processor       : 0
cpu             : 604
clock           : 150MHz
revision        : 3.5
bogomips        : 299.50

processor       : 1
cpu             : 604
clock           : 150MHz
revision        : 3.5
bogomips        : 299.50

processor       : 2
cpu             : 604
clock           : 150MHz
revision        : 3.5
bogomips        : 299.50

processor       : 3
cpu             : 604
clock           : 150MHz
revision        : 3.5
bogomips        : 299.50

total bogomips  : 11.96
zero pages      : total: 0 (0Kb) current: 0 (0Kb) hits: 0/0 (0%)
machine         : Power Macintosh
motherboard     : AAPL,9500 MacRISC
L2 cache        : 512K unified
memory          : 192MB
pmac-generation : OldWorld

------- and here's the dmesg ----------

Total memory = 192MB; using 1024kB for hash table (at c0300000)
Linux version 2.4.1-pre9 (holliday@localhost) (gcc version 2.95.3 20001130
(prerelease/franzo/20001204)) #2 SMP Sun Jan 21 20:00:36 EST 2001
Cache coherency enabled for bandit/PSX at f2000000
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Cache coherency enabled for bandit/PSX at f4000000
Found Bandit PCI host bridge at 0xf4000000. Firmware bus number: 1->1
On node 0 totalpages: 49152
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:  video=ofonly
System has 32 possible interrupts
GMT Delta read from XPRAM: 0 minutes, DST: off
via_calibrate_decr: ticks per jiffy = 125003 (750020 ticks)
Console: colour dummy device 80x25
Calibrating delay loop... 299.00 BogoMIPS
Memory: 188772k available (1652k kernel code, 1012k data, 268k init, 0k
highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Processor 1 found.
Processor 2 found.
Processor 3 found.
PCI: Probing PCI hardware
Fixup mem res, dev: 0.f, res_start: 81400000->81400000
Fixup mem res, dev: 0.f, res_start: 81000000->81000000
Fixup mem res, dev: 0.f, res_start: 80c00000->80c00000
Fixup mem res, dev: 0.f, res_start: 80800000->80800000
Fixup mem res, dev: 0.f, res_start: 81800000->81800000
Fixup mem res, dev: 0.f, res_start: 81810000->81810000
Fixup mem res, dev: 0.10, res_start: f3000000->f3000000
PCI: Resource 81400000-817fffff (f=1208, d=0, p=0)
PCI: Resource 81000000-813fffff (f=1208, d=0, p=0)
PCI: Resource 80c00000-80ffffff (f=200, d=0, p=0)
PCI: Resource 80800000-80bfffff (f=200, d=0, p=0)
PCI: Resource 81800000-8180ffff (f=200, d=0, p=0)
PCI: Resource 00000400-000004ff (f=101, d=0, p=0)
PCI: Resource f3000000-f301ffff (f=200, d=0, p=0)
Macintosh CUDA driver v0.5 for Unified ADB.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
MacOS display is /bandit/formacGA4
Using unsupported 640x480 formacGA4 at 81400000, depth=8, pitch=640
Console: switching to colour frame buffer device 80x30
fb0: Open Firmware frame buffer device on /bandit/formacGA4
input0: Macintosh mouse button emulation
pty: 256 Unix98 ptys configured
block: queued sectors max/low 125114kB/93836kB, 384 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
eth0: MACE at 08:00:07:ef:c9:9c, chip revision 9.64
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
SCSI subsystem driver Revision: 1.00
scsi0 : MESH
mesh: target 0 synchronous at 5.0 MB/s
  Vendor: QUANTUM   Model: FIREBALL SE8.4S   Rev: PJ0A
  Type:   Direct-Access                      ANSI SCSI revision: 02
mesh: target 3 synchronous at 4.2 MB/s
  Vendor: SONY      Model: CD-ROM CDU-76S    Rev: 1.1a
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : 53C94
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 16777215 512-byte hdwr sectors (8590 MB)
Partition check:
 sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
sr4146: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Macintosh non-volatile memory driver v1.0
adb devices: [2]: 2 2 [3]: 3 1
ADB keyboard at 2, handler set to 3
Detected ADB keyboard, type ANSI.
input1: ADB HID on ID 2:2.02
ADB mouse at 3, handler set to 2
input2: ADB HID on ID 3:3.01
keybdev.c: Adding keyboard: input1
mouse0: PS/2 mouse device for input2
mouse1: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice
event0: Event device for input2
event1: Event device for input1
event2: Event device for input0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 268k init 4k chrp 36k prep
Adding Swap: 131120k swap-space (priority -1)

thanks all
- Taylor


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

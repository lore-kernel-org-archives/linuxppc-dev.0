Date: Tue, 6 Feb 2001 17:37:09 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: MESH not found with 2.4.1 on 7500
Message-ID: <20010206173709.A17234@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

the current 2.4.1 can not found the mesh scsi controller on my 7500/100.
It doesnt work with bootx and boot fd:vmlinux.coff.

Any ideas how to fix it?



resetting MESH scsi bus(es)
Restarting system.
Total memory = 72MB; using 512kB for hash table (at c0380000)
Linux version 2.4.1-olaf-loop-nohighmem (root@mandarine) (gcc version
2.95.2 19991024 (release)) #1 Tue Feb 6 13:35:53 GMT 200
1
Cache coherency enabled for bandit/PSX at f2000000
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found Chaos PCI host bridge at 0xf0000000. Firmware bus number: 1->1
On node 0 totalpages: 18432
zone(0): 18432 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sdb8 init=/bin/bash rw
console=ttyS0,38400
System has 32 possible interrupts
GMT Delta read from XPRAM: 60 minutes, DST: off
Console: colour dummy device 80x25
Calibrating delay loop... 99.53 BogoMIPS
Memory: 68552k available (2016k kernel code, 996k data, 320k init, 0k
highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup mem res, dev: 0.10, res_start: f3000000->f3000000
PCI: Resource f3000000-f301ffff (f=200, d=0, p=0)
Macintosh CUDA driver v0.5 for Unified ADB.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
clgen: Driver for Cirrus Logic based graphic boards, v1.9.8
 Couldn't find PCI device
controlfb: Memory bank 1 present, bank 2 absent, total VRAM 2MB
Monitor sense value = 0x60b, using video mode 13 and color mode 2.
Console: switching to colour frame buffer device 104x39
fb0: control display adapter
input0: Macintosh mouse button emulation
PowerMac Z8530 serial driver version 2.0
ttyS0 at 0xfdf88020 (irq = 15) is a Z8530 ESCC, port = modem
ttyS1 at 0xfdf85000 (irq = 16) is a Z8530 ESCC, port = printer
pty: 256 Unix98 ptys configured
pty: 256 Unix98 ptys configured
block: queued sectors max/low 45317kB/15105kB, 192 slots per queue
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
fd0: SWIM3 floppy controller
Unable to get major 2 for floppy
NET4: Frame Diverter 0.46
loop: loaded (max 8 devices)
Machine check in kernel mode.
Caused by (from SRR1=1030): Unknown values in msr


Hmm, I will try without the loop device, but I guess that will not help.
If I use a ramdisk I get the attached output.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

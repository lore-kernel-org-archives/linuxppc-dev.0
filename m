From: "Navin Boppuri" <nboppuri@myiagent.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Compressed ramdisk found but not mounted
Date: Mon, 7 Aug 2000 15:26:41 -0500
Message-ID: <NEBBLLEGJMLHPJEFEOKPKEJFCAAA.nboppuri@myiagent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

I am working on a fads 823 board. I am trying to boot the kernel and mount
the ramdisk file system from flash. The kernel boots up just fine and also
finds the compressed ramdisk image... But nothing happens after that. It
does not mount the file system. I have all the kernel configurations set and
I have the /dev/ram device which actually points to /dev/ram1 in the
filesystem. What else could go wrong? Can someone please help?

Thank you,
Navin


8xxROM 0.3.0

compiletime options:
board: FADS DRAM_50MHZ SDRAM_50MHZ
disk: DISK_ROM

cpu: unknown 823 (0x21000000) at 56 MHz: 2Kbyte icache 1Kbyte dcache

<warning: cpu core has silicon bugs, check the errata>

board: FADS with db MPC823 rev ENG or PILOT
flash: unknown flashdelay(0x4) - defaulting to 150 ns2 Mbytes, delay 150 ns
dram: start 0 performing read
performing write
4 Mbyte, 60 ns, OK
sdram: start 400000 performing read
performing write
4 Mbyte, OK
Memory size : 8388608
main_loop status: 0  memsize 8388608
7f0000 800000
Scc2eInit end
Ramstart: 0x200000 Romstart: 0xfe020000 ZStart: 0x200000
Copied 1640836 bytes into ram memory
Starting at 0x200000
loaded at:     00200000 0020B1CC
relocated to:  00100000 0010B1CC
board data at: 007F0000 007F001C
relocated to:  00200100 0020011C
zimage at:     00206000 002658AF
initrd at:     002658AF 0037F923
avail ram:     00380000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (root@Ford) (gcc version 2.95.2 19991024 (release))
#150 Mo
n Aug 7 11:55:12 CDT 2000
Boot arguments: root=/dev/ram
LCD frame buffer 10 pages
time_init: decrementer frequency = 210000000/60
Calibrating delay loop... 55.71 BogoMIPS
Memory: 5904k available (728k kernel code, 392k data, 36k init)
[c0000000,c08000
00]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 8192 bhash 8192)
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
pty: 256 Unix98 ptys configured
lccrtmp: 12c15040
lcd_lcsr: 0
lcd_lcfaa: 100000
lcd_lchcr: 1814000
lcd_lcvcr: 78000
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 08:00:22:50:70:63
PPP: version 2.3.10 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
IP-Config: Incomplete network configuration information.
dev_close: bug eth0 still running
RAMDISK: Compressed image found at block 0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <0D9416AE7F95D411A8710008C7332F3F054382@GUILDFORD4_NT>
From: Daniel Furse <daniel.furse@iptest.com>
To: Wolfgang Denk <wd@denx.de>
Cc: "Linux Embedded List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Neighbour table overflow 
Date: Mon, 22 Jan 2001 14:38:44 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just tried a clean build, but the result is the same.

When I built the kernel, I used TQM860L_config and make oldconfig, then
edited some values with menuconfig (processor speed 80Mhz,ext2 support).

Is there anything else that I should change?

Dan

ppcboot 0.7.3 (Jan 19 2001 - 11:22:19)

Initializing...
  CPU:   XPC860xxZPnnD3 at 80 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
  Board: ### No HW ID - assuming TQM8xxL
  DRAM:  16 MB
  FLASH:  8 MB
  In:    serial
  Out:   serial
  Err:   serial

=> bootp;setenv bootargs init=/bin/bash root=/dev/nfs rw
nfsroot=$(serverip):$(r
ootpath)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off;bootm
BOOTP broadcast 1
ARP broadcast 1
TFTP from server 159.75.55.94; our IP address is 159.75.55.219
Filename '/tftpboot/pImage-TQM860L'.
Load address: 0x100000
Loading:
#######################################################################
####
done
## Booting Linux kernel at 00100000 ...
   Image Name:   2.2.14 for TQM860L
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    381908 Bytes = 372 kB = 0 MB
   Load Address: 00000000
   Entry Point:  0000000c
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.2.14 (danf@gambit.iptest.com) (gcc version 2.95.2 19991024
(rele
ase)) #11 Mon Jan 22 13:39:11 GMT 2001
Boot arguments: init=/bin/bash root=/dev/nfs rw nfsroot=159.75.55.94:
ip=159.75.
55.219:159.75.55.94::255.255.255.0:tqmboard::off
time_init: decrementer frequency = 300000000/60
Calibrating delay loop... 79.67 BogoMIPS
Memory: 15208k available (700k kernel code, 444k data, 32k init)
[c0000000,c1000
000]
Dentry hash table entries: 2048 (order 2, 16k)
Buffer cache hash table entries: 16384 (order 4, 64k)
Page cache hash table entries: 4096 (order 2, 16k)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
Found 2x16bit 4Mbyte CFI flash device of type AMD/Fujitsu standard at
40000000
registered flash device /dev/flash0
Found 2x16bit 4Mbyte CFI flash device of type AMD/Fujitsu standard at
40400000
registered flash device /dev/flash1
eth0: CPM ENET Version 0.2 on SCC1, 00:00:f8:51:78:10
Looking up port of RPC 100003/2 on 159.75.55.94			<----- By
this point the LED
neighbour table overflow
on the eth port is off
neighbour table overflow
neighbour table overflow
neighbour table overflow
portmap: server 159.75.55.94 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 159.75.55.94
neighbour table overflow
neighbour table overflow
neighbour table overflow
neighbour table overflow
portmap: server 159.75.55.94 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
neighbour table overflow
neighbour table overflow
neighbour table overflow
neighbour table overflow
mount: server 159.75.55.94 not responding, timed out
Root-NFS: Server returned error -5 while mounting /tftpboot/tqmboard
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-Id: <3.0.3.32.20021031052948.0068a870@hollabaugh.com>
Date: Thu, 31 Oct 2002 05:29:48 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Real time clock seems stuck
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks,

I'm trying to get a walnut board booted. I'm using linuxppc_2_4_devel pulled from denx yesterday. I'm getting the "Real time clock seems stuck" message then nothing, no messages after that. I found a brief thread about this.

http://lists.linuxppc.org/linuxppc-embedded/200106/msg00113.html

Have the changes suggested been put in the devel tree? If so, can someone offer some advice on how to proceed?

Here's some console output.

PPCBoot 1.2.0 (Oct 20 2002 - 19:03:26)

CPU:   IBM PowerPC 405GP Rev. D at 200 MHz (PLB=100, OPB=50, EBC=50 MHz)
           PCI sync clock at 33 MHz, internal PCI arbiter enabled
           16 kB I-Cache 8 kB D-Cache
Board: ### No HW ID - assuming WALNUT405
I2C:   ready
DRAM:  32 MB
FLASH: 512 kB
In:    serial
Out:   serial
Err:   serial
KGDB:  kgdb ready
ready
BEDBUG:ready

=> tftpboot 400000 p1
ENET Speed is 100 Mbps - FULL duplex connection
ARP broadcast 1
TFTP from server 192.168.1.11; our IP address is 192.168.1.111
Filename 'p1'.
Load address: 0x400000
Loading: #################################################################
         ############################################
done
Bytes transferred = 557872 (88330 hex)
=> imi 400000

## Checking Image at 00400000 ...
   Image Name:   Linux-2.4.20-pre11
   Created:      2002-10-31  12:17:56 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    557808 Bytes = 544.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
=> bootm 400000
## Booting image at 00400000 ...
   Image Name:   Linux-2.4.20-pre11
   Created:      2002-10-31  12:17:56 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    557808 Bytes = 544.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.20-pre11 (root@tbdev1) (gcc version 2.95.4 20010319 (prerelease/franzo/20011204)) #12 Thu Oct 31 05:13:53 MST 2002
IBM Walnut port (C) 2000-2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 1295
zone(0): 1295 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/ram
Warning: real time clock seems stuck!



then nothing after that.

Any ideas? I've searched the archives for walnut boot problems. It seems like most people just get it running and that's that.

Thanks
Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

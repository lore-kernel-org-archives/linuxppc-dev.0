Return-Path: <Agostino.Sette@siemens.com>
Received: from MILVB95A.icn.siemens.it (milvb95a.icn.siemens.it
	[83.103.117.137]) by ozlabs.org (Postfix) with ESMTP id 3529868692
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 03:57:06 +1100 (EST)
Message-ID: <69DF49BE936F4441980EC1D59F0ADC2F0108C12C@aqlby02a.siemens.it>
From: Sette Agostino <Agostino.Sette@siemens.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 7 Nov 2005 15:34:44 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Subject: PPCBoot 2.0.0 Errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have the following problem at the PPCBoot startup:

PPCBoot 2.0.0 (Oct 20 2005 - 12:28:22)
 
CPU:   unknown MPC859 (0x08010004) at 133 MHz: 16 kB I-Cache 8 kB D-Cache
FEC present
         *** Warning: CPU Core has Silicon Bugs -- Check the Errata ***
Board: Siemens CCM
       Watchdog enabled
DRAM:  Restart Reason: 0xc0000000
32 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Restart Reason: 0xc0000000
PUMA:  env. variable puma_addr undefined
Net:   FEC ETHERNET

Furthermore, at the kernel startup I have:

## Booting image at 40180000 ...
   Image Name:   Linux-2.4.20-rthal5
   Created:      2004-10-04  10:14:39 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    614355 Bytes = 599.10 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
IP-Config: Gateway not on directly connected network.
init started:  BusyBox v0.60.5 (2003.11.19-14:32+0000) multi-callmount:
Mounting devpts on /dev/pts failed: No su
ch file or directory
/opt/rc.project: /opt/bin/sinfo: No such file or directory
export USER='root'
export HOME='/'
export wdt_8xx='timeout:120'
export TERM='linux'
export PATH='/usr/bin:/bin:/usr/sbin:/sbin'
export SHELL='/bin/sh'
export PWD='/'
export mem='32512k'
/opt/rc.project: /opt/bin/sinfo: No such file or directory
export USER='root'
export HOME='/'
export wdt_8xx='timeout:120'
export TERM='linux'
export PATH='/usr/bin:/bin:/usr/sbin:/sbin'
export SHELL='/bin/sh'
export PWD='/'
export mem='32512k'

Anybody experienced the same problem? Any suggestions about how to solve it?


Thanks in advance,
Agostino

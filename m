Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id CBFEFDE2F3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 22:42:52 +1100 (EST)
Received: by bwz3 with SMTP id 3so3119448bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:42:51 -0800 (PST)
Message-ID: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
Date: Thu, 15 Jan 2009 12:42:50 +0100
From: "Jean-Michel Hautbois" <jhautbois@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [MPC8272ADS]Cannot start my Linux Kernel
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7915_15708932.1232019770905"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_7915_15708932.1232019770905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody !

This my first (but not least :) ) message on that mailing list. I hope I
will find my solution.
Here is my problem:

I have a MPC8272ADS board, 64MB RAM, 8MB Flash.
I compiled u-boot using the existing config file, and compiled my linux
kernel successfully with the defconfig file too.

I have updated u-boot, downloaded my kernel file, and a ramdisk image from
the eldk distribution.
I have tried using a lot of bootargs (
bootargs root=/dev/ram rw console=ttyS0,115200
bootargs through nfs, etc.)

When I am resetting my card, it reboots:
bootargs=root=/dev/ram rw console=ttyS0,115200
bootcmd=bootm ff800000 ff980000

## Booting kernel from Legacy Image at ff800000 ...
   Image Name:   Linux-2.6.29-rc1-01197-g5a7b6e7-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1487167 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at ff980000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1730966 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 039d7000, end 03b7d996 ... OK


U-Boot 2009.01 (Jan 14 2009 - 18:38:32)

MPC8272 Reset Status: Check Stop, External Soft, External Hard

MPC8272 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3, pcidf 5
 - vco_out  400000000, scc_clk  100000000, brg_clk   25000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000
 - pci_clk   66666666

CPU:   MPC8272 (HiP7 Rev 14, Mask 1.0 1K50M) at 400 MHz
Board: Motorola MPC8272ADS
DRAM:  64 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC1 ETHERNET
Hit any key to stop autoboot:  0
=>


Thanks in advance for your help !

------=_Part_7915_15708932.1232019770905
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody !<br><br>This my first (but not least :) ) message on that mailing list. I hope I will find my solution.<br>Here is my problem:<br><br>I have a MPC8272ADS board, 64MB RAM, 8MB Flash.<br>I compiled u-boot using the existing config file, and compiled my linux kernel successfully with the defconfig file too.<br>
<br>I have updated u-boot, downloaded my kernel file, and a ramdisk image from the eldk distribution.<br>I have tried using a lot of bootargs (<br>bootargs root=/dev/ram rw console=ttyS0,115200<br>bootargs through nfs, etc.)<br>
<br>When I am resetting my card, it reboots:<br>bootargs=root=/dev/ram rw console=ttyS0,115200<br>bootcmd=bootm ff800000 ff980000<br><br>## Booting kernel from Legacy Image at ff800000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.29-rc1-01197-g5a7b6e7-<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1487167 Bytes =&nbsp; 1.4 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>## Loading init Ramdisk from Legacy Image at ff980000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Simple Embedded Linux Framework<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1730966 Bytes =&nbsp; 1.7 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>&nbsp;&nbsp; Loading Ramdisk to 039d7000, end 03b7d996 ... OK<br><br><br>U-Boot 2009.01 (Jan 14 2009 - 18:38:32)<br><br>MPC8272 Reset Status: Check Stop, External Soft, External Hard<br><br>MPC8272 Clock Configuration<br>
&nbsp;- Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq&nbsp; 25-75 , Core Freq 100-300<br>&nbsp;- dfbrg 1, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3, pcidf 5<br>&nbsp;- vco_out&nbsp; 400000000, scc_clk&nbsp; 100000000, brg_clk&nbsp;&nbsp; 25000000<br>&nbsp;- cpu_clk&nbsp; 400000000, cpm_clk&nbsp; 200000000, bus_clk&nbsp; 100000000<br>
&nbsp;- pci_clk&nbsp;&nbsp; 66666666<br><br>CPU:&nbsp;&nbsp; MPC8272 (HiP7 Rev 14, Mask 1.0 1K50M) at 400 MHz<br>Board: Motorola MPC8272ADS<br>DRAM:&nbsp; 64 MB<br>FLASH:&nbsp; 8 MB<br>In:&nbsp;&nbsp;&nbsp; serial<br>Out:&nbsp;&nbsp; serial<br>Err:&nbsp;&nbsp; serial<br>Net:&nbsp;&nbsp; FCC1 ETHERNET<br>
Hit any key to stop autoboot:&nbsp; 0 <br>=&gt; <br><br><br>Thanks in advance for your help !<br>

------=_Part_7915_15708932.1232019770905--

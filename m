Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E63484A.6340720C@tataelxsi.co.in>
Date: Mon, 03 Mar 2003 17:49:23 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: RAMDISK Problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

As suggested, i downloaded the "simple-ramdisk.PPCBoot" from ftp site
and also went thru the dplg.pdf file to know more about PPCBoot.

Iam working on MPC8260ADS and trying to boot linux-2.4.1 in a standalone
mode without NFS support.

I loaded both kernel image which was booting earlier with NFS system and
newly downloaded ramdisk at address 100000 and 200000 respectively. And
i also updated the bootargs environment variable as
---
setenv bootargs root=/dev/ram
ip=10.1.40.176:10.1.40.175:10.1.1.1:255.255.0.0:10.1.40.175::off
---

where,
target ip = 10.1.40.176
server ip = 10.1.40.175
gateway ip = 10.1.1.1
netmask = 255.255.0.0
host name = 10.1.40.175

I have checked ip addresses for correctness.

After all this, i gave bootm 100000 200000 command.

Output:
After loading kernel image and ramdisk image, it is hanging!!!

--- Messages ---

## Booting Linux kernel at 10100000 ...
     Image Name: Linux-2.4.1
     Image Type: PowerPC Linux Kernel Image (gzip compressed)
     Data Size: 400259 Bytes = 390 kB = 0 MB
     Load Address: 00000000
     Entry Point: 00000000
     Verifying Checksum ... OK
     Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 10200000 ...
     Image Name: Simple Ramdisk Image
     Image Type: PowerPC Linux RAMDisk Image (gzip compressed)
     Data Size: 507630 Bytes = 495 kB = 0 MB
     Load Address: 00000000
     Entry Point: 00000000
     Verifying Checksum ... OK
     Loading Ramdisk to 00ed4000, end 00f5eab4 ... OK

    [After this, no messages]
--- Messages ---

I am stuck at this point and don't know what could be the reason. Can
somebody help me?

thanks in advance,
with rgds,
kamal


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

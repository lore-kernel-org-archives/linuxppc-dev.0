Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030211064911.50039.qmail@web8007.mail.in.yahoo.com>
Date: Mon, 10 Feb 2003 22:49:11 -0800 (PST)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: Combine kernel and ramdisk image.
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I want to combine the Linux kernel Image and the
ramdisk image.I had used the mkimage tool for doing
this
./mkimage -A ppc -O Linux -T multi  -C gzip \
-n 'Linux-2.4.4-2002-03-21 Multiboot-Image' -e 0 -a 0
\
-d /SELF/build/linux-2.4.4-2002-03-21/arch/ppc/
coffboot/vmlinux.gz:/SELF/build/ramdisk_image.gz \
/SELF/images/pMulti

PMulti is the Combined kernal image ..
wheni download it to the powerpc board using ppcboot I
get this .

bootm
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.4-2002-03-21 Multiboot
   Image Type:   PowerPC Linux Multi-File Image (gzip
compressed)
   Data Size:    1580442 Bytes = 1543 kB = 1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Contents:
   Image 0:   530861 Bytes = 518 kB = 0 MB
   Image 1:  1049566 Bytes = 1024 kB = 1 MB
   Verifying Checksum ... OK
   Uncompressing Multi-File Image ... OK
   Loading Ramdisk to 6fabe000, end 0075a4bc ...



what could be the error....
when i downlaod the kernel and  the ramdisk separately
then the ramdisk gets loaded at this address

Loading Ramdisk to 0065a000, end 0075a3de ... OK
Linux version 2.4.4 (root@UCLinuxServer.embedded) (gcc
version 2.95.3 20010315
.................

Thankyou.








Yahoo! Shopping - Send Flowers for Valentine's Day
http://shopping.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

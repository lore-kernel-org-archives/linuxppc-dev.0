Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C9F67A5.827D4BBC@snom.de>
Date: Mon, 25 Mar 2002 19:08:37 +0100
From: Sven Boehringer <boehringer@snom.de>
Reply-To: boehringer@snom.de
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem booting Linux on MPC8XXFADS
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

i read the lists and some manuals but i can't find any solution that fit
to my problem.
I use ppcboot-1.1.4 (yes i know, there is a newer one :-) an the
kernel-sources 2.4.17 (from ftp.kernel.org). As HW i use a MPX8xxFADS
with an 855T on it:


-PPCBoot 1.1.4 (Mar 25 2002 - 11:33:16)

-CPU:   XPC860xxZPnnD3 at 49.800 MHz: 4 kB I-Cache 4 kB D-Cache FEC
present
-Board: FADS with db MPC821, MPC860 / MPC860SAR / MPC860T rev ENG or
PILOT
-DRAM:  (4 MB SDRAM) 12 MB
-FLASH:  2 MB
-In:    serial
-Out:   serial
-Err:   serial

The boot messages looking like this:


=>bootm 0200000
## Booting image at 00200000 ...
   Image Name:   2.4.17 Ver.0.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    475397 Bytes = 464 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

An then no further output :-(
I also tried, that with 2.4.4-Sources from ftp.denx.de
(linux-2.4.4-2002-03-21.tar.bz2) but still the same problem. And i also
downloaded the kernel image to 02840000 which ist the base adress of my
flash memory, looks the same.

And i also checked the following sentences in the README:
<snip>
Just make sure your machine specific header file (for instance
include/asm-ppc/tqm8xx.h) includes the same definition of the Board
Information structure as we define in include/ppcboot.h, and make
sure that your definition of IMAP_ADDR uses the same value as your
PPCBoot configuration in CFG_IMMR.
<snip>


But i have still problems at this point.


can somebody help me? Sorry if that is a newbie question..

thanks in advance,

Sven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 15 Aug 2001 17:18:52 -0700
Message-Id: <200108151718.AA2709455104@redsonic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Zeke  Burgess" <zburgess@redsonic.com>
Reply-To: <zburgess@redsonic.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel 2.4.3 on TQM823L
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks to help from here and elsewhere, I have my TQM823L booting and running on kernel 2.4.4.  This is well and good, but I have been asked to get 2.4.3 to work on the same board.   Here I have problems. Namely, the kernel bails silently while trying to start the mmu (at least that is what it appears to happen).

ppcboot 1.0.3 using tftpboot gives:
## Booting image at 00100000 ...
   Image Name:   blahblah815
   Created:      2001-08-15  20:09:02 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    579601 Bytes = 566 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

which looks good to me.

So, my question is, what is the big change between 2.4.3 and 2.4.4 (I have tried stock versions of each from kernel.org)?  Is it worth the time to try to make it work?

Thanks,

Zeke Burgess


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: Leonardo M Teixeira <leonardo@lst.cpdtt.cefetpr.br>
To: linuxppc-embedded@lists.linuxppc.org
Subject: LINUX on FADS860
Date: Thu, 11 Jan 2001 11:03:12 -0200
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01011111050500.00597@proteus>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Helo,

I am new on embedded world, and I am trying to run
LINUX on my FADS860 board, only for a small presentation.

I have the CDK1.2, from MVista, installed and working, and ppcboot-0.7.1
(with "FADS860T_config") running on my fads860.

I download a pakage (kernel) from MontaVista ftp site, a Linux Support Package (LSP)
(hhl-ppc_8xx-fads860-lsp-2.4.0-test2-1.2.0-1-0.0.1-3.noarch.rpm), whos (??) give
support to FADS860. Compille it with MV tools (using "make menuconfig".. make zImage...).

But the kernel crash all the time...

Can I get some help from this list?
Any help is welcome.

Thank in advance.

Leonardo

---------( some outputs from the board )-----------------------

=>imi 2880000

## Checking Image at 02880000 ...
   Image Name:   2.4.0 for initrd on FADS860
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    471204 Bytes = 460 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
=>bootm 2880000
## Booting Linux kernel at 02880000 ...
   Image Name:   2.4.0 for initrd on FADS860
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    471204 Bytes = 460 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

----------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Mouloud Ameni " <mameni@caramail.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <1091701221032720@lycos-europe.com>
Mime-Version: 1.0
Subject: Can't load linux to est8260
Date: Thu, 05 Aug 2004 10:20:21 GMT 
Content-Type: multipart/mixed; boundary="=_NextPart_Lycos_0327201091701221_ID"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Lycos_0327201091701221_ID
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit

hi all,
I have succeeded in building a 2.4.18 linux kernel, but when i try to load it to the est8260 board it hangs for
some reasons. I am using u-boot 1.0.0 . the message i get is as follows:

=> bootm
## Booting image at 00400000 ...
   Image Name:   Linux 2.4.18
   Created:      2004-08-03  12:45:38 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    490663 Bytes = 479.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

and then crashes. I used these commands to build the kernel:

$ make ARCH=ppc CROSS_COMPILE=powerpc-uclibc- est8260_config
$ make ARCH=ppc CROSS_COMPILE=powerpc-uclibc- oldconfig
$ make ARCH=ppc CROSS_COMPILE=powerpc-uclibc- clean dep
$ make ARCH=ppc CROSS_COMPILE=powerpc-uclibc- zImage

and then i used "mkimage" to build a uImage.

The "IMMR" value in the ppcboot.h is given as "0x0f000000", so i changed this value in the kernel configuration
to be the same, as well.
please anyone who has succeeded to load the kernel to an est8260 board can help me with this
thanx in advance

Pour gagner une Playstation 2, envoyez un SMS avec le code PS au 61321 (0,35 euro hors coût du SMS).


--=_NextPart_Lycos_0327201091701221_ID--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

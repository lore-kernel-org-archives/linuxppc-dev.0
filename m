Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: RE: RAMDISK problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 12 Nov 2003 16:01:43 -0500
Message-ID: <AB5AF73EAF23304EA1B932174137CED703042C@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A silly question but...
Why does U-boot report a ramdisk size of about 555kB,
while the original from Denx's ftp server has a size of 1.33MB ?

Is it possible that the kernel runs out of data while booting ?
Or may be you just strip the ramdisk image?
If so, what is the expected size once it is uncompressed?
Would it be advisable to increase the CONFIG_BLK_DEV_RAM_SIZE?

Regards,

--------------------------------------------
 Jean-Denis Boyer, Eng.
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Joao
> Vicente
> Sent: 11 novembre, 2003 10:45
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: RAMDISK problem
>
>
>
> Hi
>
> I am struggling with a problem where I dont seem to be able
> to mount a boot filesystem from a RAMDISK.
> I am using the sample RAMDisk root filesystem available from
> Denx's ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/ppc_82xx/
>
[...]
>
> ## Checking Image at 03000000 ...
>    Image Name:   Simple Ramdisk-Image
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    567988 Bytes = 554.7 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Booting image at 00100000 ...
>    Image Name:   Linux-2.4.20
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    595016 Bytes = 581.1 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
[...]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

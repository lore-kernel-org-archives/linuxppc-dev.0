Return-Path: <Leonid@a-k-a.net>
Received: from mis011-2.exch011.intermedia.net
	(mis011-2.exch011.intermedia.net [64.78.21.129])
	by ozlabs.org (Postfix) with ESMTP id A75DDDDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 10:50:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: u-boot+linux for ML403 board.
Date: Thu, 15 Mar 2007 16:50:15 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C0129DDD5@ehost011-3.exch011.intermedia.net>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19B@MERCURY.inside.istor.com>
References: <7691A67C-C3D9-4882-9BCC-E3AA617AD11E@kernel.crashing.org>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19B@MERCURY.inside.istor.com>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

Does anybody use u-boot+linux on ML403 board? If yes, can somebody give
me kernel or kernel patch to any open source kernel tree (DENX or
kernel.org).

I couldn't prepare uImage which is working with u-boot on ML403 board -
it hangs forever:

TFTP from server 192.168.0.141; our IP address is 192.168.0.203
Filename 'LM200/rel/1.0.1d-403/uImage'.
Load address: 0x400000
Loading: T
#################################################################
=20
#################################################################
         #######################################
done
Bytes transferred =3D 861911 (d26d7 hex)
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.19.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    861847 Bytes =3D 841.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x03E676F0 =3D> set upper limit to 0x00800000
Board Info pointer (kbd) at 007ffe80 ## cmdline at 0x007FFF00 ...
0x007FFFF8
memstart    =3D 0x00000000
memsize     =3D 0x04000000
flashstart  =3D 0x28000000
flashsize   =3D 0x00800000
flashoffset =3D 0x00000000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
bootflags   =3D 0x00000000
procfreq    =3D    300 MHz
plb_busfreq =3D    100 MHz
ethaddr     =3D 00:01:02:CB:CB:71
IP addr     =3D 192.168.0.203
baudrate    =3D 115200 bps
No initrd
## Transferring control to Linux (at address 00000000) ..

Thanks,

Leonid.

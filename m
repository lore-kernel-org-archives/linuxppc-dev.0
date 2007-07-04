Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id CF543DDEC1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 23:24:50 +1000 (EST)
Message-Id: <20070704132212.726923000@pademelon.sonytel.be>
Date: Wed, 04 Jul 2007 15:22:12 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@kernel.dk>,
	"James E.J.  Bottomley" <James.Bottomley@SteelEye.com>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: [patch 0/6] PS3 Storage Drivers for 2.6.23, take 4
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi,

This is the fourth submission of the new PS3 storage drivers:
  [1] ps3: Preallocate bootmem memory for the PS3 FLASH ROM storage driver
  [2] ps3: Storage Driver Core
  [3] ps3: Storage device registration routines.
  [4] ps3: Disk Storage Driver
  [5] ps3: BD/DVD/CD-ROM Storage Driver
  [6] ps3: FLASH ROM Storage Driver

They are based on:
  - the current Linux kernel source tree,
  - plus the PS3 patches already submitted by Geoff Levand on linuxppc-dev,
  - plus the shost_priv() patch in scsi-misc (commit
    bcd92c9fbcc679ee95003083056f0441a1f474fa).

All issues raised during the previous review rounds should be fixed.
There were no more comments after the third submission.

Paul already integrated Geoff Levand's PS3 patches and the first 3 patches
in this series in the for-2.6.23 branch in powerpc.git.

Maintainers of block/SCSI/misc, can you please ack the last 3 patches so Paul
can take them, too?

Thanks in advance!

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619

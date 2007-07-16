Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 6B73EDDFDF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 02:22:56 +1000 (EST)
Message-Id: <20070716161539.075822000@pademelon.sonytel.be>
Date: Mon, 16 Jul 2007 18:15:39 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@kernel.dk>,
	"James E.J.  Bottomley" <James.Bottomley@SteelEye.com>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: [patch 0/3] PS3 Storage Drivers for 2.6.23, take 5
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

These are the remaining patches of the new PS3 storage drivers series:
  [1] ps3: Disk Storage Driver
  [2] ps3: BD/DVD/CD-ROM Storage Driver
  [3] ps3: FLASH ROM Storage Driver

They are based on:
  - the current Linux kernel source tree,
  - plus the PS3 patches already submitted by Geoff Levand on linuxppc-dev,
    which are in the for-2.6.23 branch of Paulus' tree,
  - plus the first 3 patches from the PS3 storage drivers series I submitted
    before, which are also in the for-2.6.23 branch of Paulus' tree.

The only changes compared to the previous submission are the kmap updates, as
requested by Jens Axboe and James E.J. Bottomley.

I didn't hear anything from the misc device maintainer (for the FLASH ROM
Storage Driver).

Paulus, please apply.  Thanks in advance!

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

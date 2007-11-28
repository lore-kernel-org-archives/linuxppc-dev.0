Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 39D14DDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 01:35:17 +1100 (EST)
Message-Id: <20071128143142.580732000@pademelon.sonytel.be>
Date: Wed, 28 Nov 2007 15:31:42 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: [patch 0/7] PS3 notification device patches for 2.6.25
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi all,

Here are my PS3 notification device patches for 2.6.25:
  [1] ps3: Make bus_id and dev_id u64
  [2] ps3: Add ps3_repository_find_device_by_id()
  [3] ps3: Use the HV's storage device notification mechanism properly
  [4] ps3: Add repository polling loop to work around hypervisor bug
  [5] ps3: Kill unused ps3_repository_bump_device()
  [6] ps3: Refactor ps3_repository_find_device()
  [7] ps3: denoise arch/powerpc/platforms/ps3/repository.c

These patches correct the use of the PS3 notification device mechanism, which
allows to wait until a storage device is ready.

Please review, thanks!

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

Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 1CFE2DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 19:56:48 +1000 (EST)
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 1325258ABD
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 11:56:43 +0200 (MEST)
Date: Fri, 12 Oct 2007 11:56:42 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: linux-2.6.git: cannot build PS3 image
Message-ID: <Pine.LNX.4.62.0710121152500.28100@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-713630467-1192183002=:28100"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-713630467-1192183002=:28100
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On current linux-2.6.git (782e3b3b3804c38d5130c7f21d7ec7bf6709023f), I get:

|   WRAP    arch/powerpc/boot/zImage.ps3
| DTC: dts->dtb  on file "/usr/people/geert.nba/ps3/ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts"
| ln: accessing `arch/powerpc/boot/zImage.ps3': No such file or directory

`make V=1' gives:

|   /bin/sh ps3-linux-2.6/arch/powerpc/boot/wrapper -c -o arch/powerpc/boot/zImage.ps3 -p ps3 -C "ppu-"  -s ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts vmlinux
| DTC: dts->dtb  on file "ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts"
| ln: accessing `arch/powerpc/boot/zImage.ps3': No such file or directory

I don't see a change to arch/powerpc/boot/Makefile that could explain this.

Anyone with a clue? Thx!

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
---584337861-713630467-1192183002=:28100--

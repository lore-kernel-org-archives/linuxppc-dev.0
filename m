Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id ECC45DDF9A
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 04:27:49 +1100 (EST)
Message-Id: <20071126172455.308741000@pademelon.sonytel.be>
Date: Mon, 26 Nov 2007 18:24:55 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: [patch 0/9] ps3av/fb patches for 2.6.25
Sender: Geert Uytterhoeven <geert@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi,

Here is a first bunch of ps3av/fb patches for 2.6.25:
  [1] ps3av: ps3av_get_scanmode() and ps3av_get_refresh_rate() are unused
  [2] ps3: Use symbolic names for video modes
  [3] ps3fb: Kill PS3FB_FULL_MODE_BIT
  [4] ps3fb: Inline macros that are used only once
  [5] ps3fb: Kill ps3fb_res[]
  [6] ps3fb: Make frame buffer offset unsigned int
  [7] ps3fb: Configurable black borders
  [8] ps3fb: Reorganize modedb handling
  [9] ps3fb: Round up video modes

Thanks for reviewing!

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

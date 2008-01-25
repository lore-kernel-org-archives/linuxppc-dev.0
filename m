Return-Path: <geert@sonycom.com>
Message-Id: <20080125150623.202631389@vixen.sonytel.be>
Date: Fri, 25 Jan 2008 16:06:23 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 00/11] ps3av/3fb patches for 2.6.25
Sender: geert <geert@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Tony, Andrew,

Hare are the ps3av/fb patches for 2.6.25:
  [1] ps3av: ps3av_get_scanmode() and ps3av_get_refresh_rate() are unused
  [2] ps3: Use symbolic names for video modes
  [3] ps3fb: Kill PS3FB_FULL_MODE_BIT
  [4] ps3fb: Inline macros that are used only once
  [5] ps3fb: Kill ps3fb_res[]
  [6] ps3fb: Make frame buffer offsets unsigned int
  [7] ps3fb: Add support for configurable black borders
  [8] ps3fb: Reorganize modedb handling
  [9] ps3fb: Round up video modes
  [10] ps3fb: Cleanup sweep
  [11] ps3fb: Fix modedb typos

Patches 1-9 have been sent for review on Mon, 26 Nov 2007. They haven't
changed in the mean time, except for rebasing and minor editing of patch
descriptions.
Patches 10-11 are new, but not very complex, and tested in ps3-linux.git since
a while.

Please apply for 2.6.25. Thanks a lot!

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

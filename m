Return-Path: <geert@sonycom.com>
Message-Id: <20070926163308.772580000@pademelon.sonytel.be>
Date: Wed, 26 Sep 2007 18:33:08 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 0/8] PS3 AV Settings Driver patches for 2.6.24
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi,

Here are some new patches for the PS3 AV Settings Driver (ps3av), which is
used in close collaboration with the PS3 Virtual Frame Buffer Device Driver
(ps3fb):
  [1] ps3av: eliminate unneeded temporary variables
  [2] ps3av: eliminate PS3AV_DEBUG
  [3] ps3av: use PS3 video mode ids in autodetect code
  [4] ps3av: treat DVI-D like HDMI in autodetect
  [5] ps3av: add autodetection for VESA modes
  [6] ps3av: add quirk database for broken monitors
  [7] ps3av: remove unused ps3av_set_mode()
  [8] ps3av: don't distinguish between `boot' and `non-boot' autodetection

Please review, and queue for 2.6.24 if they're ok. Thanks!

Question: As several DVI-D displays advertise they support 1080i modes while
they actually don't (cfr. the quirk database), perhaps I should drop 1080i
modes completely from the ps3av_preferred_modes[] table? Usually 720p looks
better than 1080i anyway.  What do you think?

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

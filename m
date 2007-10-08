Return-Path: <geert@sonycom.com>
Message-Id: <20071008161421.818458000@pademelon.sonytel.be>
Date: Mon, 08 Oct 2007 18:14:21 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 0/9] PS3 Virtual Frame Buffer Device Driver patches for 2.6.24
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

Here are some new patches for the PS3 Virtual Frame Buffer Device Driver
(ps3fb):
  [1] ps3fb: Convert from printk()/DPRINTK() to dev_*()/pr_*()
  [2] ps3fb: Do not print warnings on invalid frame numbers
  [3] ps3fb: Clean up includes
  [4] ps3fb: Make ps3fb_wait_for_vsync() and ps3fb_flip_ctl() static
  [5] ps3fb: Fix possible overlap of GPU command buffer and frame buffer
  [6] ps3fb: Use fb_info.par properly
  [7] ps3fb: Don't keep the borders for non-fullscreen modes in XDR memory
  [8] ps3fb: Add virtual screen and panning support
  [9] ps3fb: Enhance horizontal panning on firmware 1.90 and up

Please review, and queue for 2.6.24 if they're ok. Thanks!

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

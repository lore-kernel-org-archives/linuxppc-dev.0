Return-Path: <geert@sonycom.com>
Message-Id: <20071012145052.640177000@pademelon.sonytel.be>
Date: Fri, 12 Oct 2007 16:50:52 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 00/13] ps3av/fb patches for 2.6.24
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

        Hi Tony, Andrew,

Here are the remaining patches for the PS3 Audio/Video Settings Driver (ps3av)
and the PS3 Virtual Frame Buffer Device Driver (ps3fb) that are not yet in
2.6.23-mm1:
   [1] ps3av: Fix black and white stripes
   [2] ps3fb: Fix spurious mode change failures
   [3] ps3fb: Convert from printk()/DPRINTK() to dev_*()/pr_*()
   [4] ps3fb: Do not print warnings on invalid frame numbers
   [5] ps3fb: Clean up includes
   [6] ps3fb: Make ps3fb_wait_for_vsync() and ps3fb_flip_ctl() static
   [7] ps3fb: Fix possible overlap of GPU command buffer and frame buffer
   [8] ps3fb: Use fb_info.par properly
   [9] ps3fb: Don't keep the borders for non-fullscreen modes in XDR memory
  [10] ps3fb: Add virtual screen and panning support
  [11] ps3fb: Enhance horizontal panning on firmware 1.90 and up
  [12] fb: Move and rename extern declaration for global_mode_option
  [13] ps3fb: Default to 480p on DVI-D/HDMI if video=safe

Patches 1-2 are old bug fixes that didn't make it into 2.6.23.

Patches 3-11 were submitted for review last week and received no comments.

Patches 12-13 introduce a safe mode for DVI-D/HDMI displays, to be used by
`kboot'-style boot loaders (i.e. first-stage kernels), as requested by
reviewers of the PS3 video mode autodetection patches (which are in
2.6.23-mm1).

Please apply, thanks!

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

Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id ECD9EDDEDA
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:56:23 +1100 (EST)
Date: Thu, 8 Feb 2007 14:56:21 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/10] ps3av/fb drivers for 2.6.21
Message-ID: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Andrew,

This is the third submission of the PS3 AV Settings Driver and the PS3 Virtual
Frame Buffer Driver.

Patch summaries:
[PATCH 1/10] ps3: Add shutdown to virtual uart port driver framework
[PATCH 2/10] ps3: AV Settings Driver
[PATCH 3/10] fbdev modedb: allow refresh rates for named video modes
[PATCH 4/10] fbdev modedb: make more pointer parameters const
[PATCH 5/10] fb_videomode_to_var: reset virtual screen parameters
[PATCH 6/10] ps3: Preallocate bootmem memory for ps3fb
[PATCH 7/10] ps3: Virtual Frame Buffer Driver
[PATCH 8/10] ps3: disable display flipping during mode changes
[PATCH 9/10] ps3: cleanup ps3fb before clearing HPTE
[PATCH 10/10] ps3: ps3av/fb defconfig updates

All patches apply to current linux-2.6.git.

Note that the first 3 frame buffer-specific patches are not PS3-specific:
  - Without patch 3 you cannot select all available video modes through the
    kernel command line,
  - Patch 4 is just a cleanup while I was working on the code,
  - Without patch 5 you cannot use the ps3videomode command line tool or
    /sys/class/graphics/fb0/mode to switch to a video mode with a lower
    resolution.

Please apply, so we can have this in 2.6.21. Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

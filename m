Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 866AADE064
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 04:46:41 +1100 (EST)
Date: Thu, 25 Jan 2007 18:46:39 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/9] ps3av/fb drivers for 2.6.21
Message-ID: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi James, Paul,

This is the first submission of the PS3 AV Settings Driver and the PS3 Virtual
Frame Buffer Driver.

To ease the review, I'm sending all patches to both relevant maintaines and
mailing lists.

[PATCH 1/9] ps3: AV Settings Driver
[PATCH 2/9] fbdev modedb: allow refresh rates for named video modes
[PATCH 3/9] fbdev modedb: make more pointer parameters const
[PATCH 4/9] fb_videomode_to_var: reset virtual screen parameters
[PATCH 5/9] ps3: Preallocate bootmem memory for ps3fb
[PATCH 6/9] ps3: Virtual Frame Buffer Driver
[PATCH 7/9] ps3: disable display flipping during mode changes
[PATCH 8/9] ps3: cleanup ps3fb before clearing HPTE
[PATCH 9/9] ps3: ps3av/fb defconfig updates

PowerPC-specific patches (1, 5, 7, 8 and 9) apply on top of the patches sent
by Geoff Levand to linuxppc-dev yesterday.
Frame buffer specific-patches (2, 3, 4, and 6) apply on Linus' current tree.

Please review. All comments are welcome.
Our goal is to get these drivers integrated into 2.6.21.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id F05FADE079
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 04:55:26 +1100 (EST)
Date: Thu, 25 Jan 2007 18:55:24 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/9] ps3av/fb drivers for 2.6.21
In-Reply-To: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0701251852510.24610@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
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


Sorry, I forgot to mention that the following 3 patches are not really
PS3-specific:

> [PATCH 2/9] fbdev modedb: allow refresh rates for named video modes

Without this you cannot select all available video modes through the kernel
command line.

> [PATCH 3/9] fbdev modedb: make more pointer parameters const

Just a cleanup while working on the code.

> [PATCH 4/9] fb_videomode_to_var: reset virtual screen parameters

Without this you cannot use the ps3videomode command line tool or
/sys/class/graphics/fb0/mode to switch to a video mode with a lower resolution.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

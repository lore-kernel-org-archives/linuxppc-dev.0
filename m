Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 64B5FDDEF4
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 22:49:43 +1000 (EST)
Message-Id: <20070502124830.911142000@pademelon.sonytel.be>
Date: Wed, 02 May 2007 14:48:30 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 0/8] PS3 AV/FB patches
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Antonino Daplas <adaplas@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

        Hi Linus, Andrew,

Here are our patches for the PS3 Audio Video Settings and Virtual Frame
Buffer
drivers for 2.6.22:

[1/8] ps3fb: thread updates
[2/8] ps3fb: atomic fixes
[3/8] ps3av: thread updates
[4/8] ps3fb: kill superfluous zero initializations
[5/8] ps3av: misc updates
[6/8] [PATCH] ps3: Make `ps3videomode -v 0' (auto mode) work again
[7/8] ps3fb: Use __func__ instead of __FUNCTION__
[8/8] ps3av: Use __func__ instead of __FUNCTION__

The last 3 are new, but they are quite simple/trivial.

Please apply. Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

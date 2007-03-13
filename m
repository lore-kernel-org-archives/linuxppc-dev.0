Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id CBA58DDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 01:22:15 +1100 (EST)
Message-Id: <20070313141910.001573000@sonycom.com>
Date: Tue, 13 Mar 2007 15:19:10 +0100
From: Geert.Uytterhoeven@sonycom.com
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 0/5] PS3 AV/FB updates
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net,
	James Simmons <jsimmons@infradead.org>,
	"Antonino A. Daplas" <adaplas@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are a few updates for the PS3 Audio/Video Settings Driver and the PS3
Virtual Frame Buffer Driver:

[PATCH 1/5] ps3fb: thread updates
[PATCH 2/5] ps3fb: atomic fixes
[PATCH 3/5] ps3av: thread updates
[PATCH 4/5] ps3fb: kill superfluous zero initializations
[PATCH 5/5] ps3av: misc updates

Please apply for 2.6.21. Thx!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

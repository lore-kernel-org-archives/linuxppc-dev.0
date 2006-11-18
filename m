Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 5A4EC67BEC
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 11:02:36 +1100 (EST)
Date: Sat, 18 Nov 2006 01:02:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net, James Simmons <jsimmons@infradead.org>
Subject: [RFC: 2.6 patch] remove broken video drivers
Message-ID: <20061118000235.GV31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sammy@sammy.net, linux-fbdev-devel@lists.sourceforge.net,
	sun3-list@redhat.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-m68k@lists.linux-m68k.org,
	geert@linux-m68k.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes video drivers that:
- had already been marked as BROKEN in 2.6.0 three years ago and
- are still marked as BROKEN.

These are the following drivers:
- FB_CYBER
- FB_VIRGE
- FB_RETINAZ3
- FB_ATARI
- FB_SUN3
- FB_PM3

Drivers that had been marked as BROKEN for such a long time seem to be 
unlikely to be revived in the forseeable future.

But if anyone wants to ever revive any of these drivers, the code is 
still present in the older kernel releases.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Due to it's size, the patch is available at
  http://ftp.kernel.org/pub/linux/kernel/people/bunk/misc/patch-remove-broken-video.gz

 drivers/video/Kconfig   |   62 
 drivers/video/Makefile  |    6 
 drivers/video/atafb.c   | 3107 ----------------------------------
 drivers/video/cyberfb.c | 2297 -------------------------
 drivers/video/cyberfb.h |  415 ----
 drivers/video/pm3fb.c   | 3641 ----------------------------------------
 drivers/video/retz3fb.c | 1588 -----------------
 drivers/video/retz3fb.h |  286 ---
 drivers/video/sun3fb.c  |  702 -------
 drivers/video/virgefb.c | 2526 ---------------------------
 drivers/video/virgefb.h |  288 ---
 include/video/pm3fb.h   | 1235 -------------
 12 files changed, 3 insertions(+), 16150 deletions(-)

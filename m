Return-Path: <geoff@infradead.org>
Message-Id: <1d082300a03a735c006739907e6aea082007663c.1433959045.git.geoff@infradead.org>
In-Reply-To: <cover.1433959045.git.geoff@infradead.org>
References: <cover.1433959045.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/3] MAINTAINERS: Update ps3vram block driver
To: Jens Axboe <axboe@kernel.dk>
Cc: Jim Paris <jim@jtan.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2015 18:00:18 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add myself as co-maintainer of the ps3vram block driver, and add linuxppc-dev
as a relevant mailing list.

I have been acting as maintainer of this driver for the last several years, and
if there is some inquiry regarding it I would like to be notified.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8afd29..921809b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7882,6 +7882,8 @@ F:	sound/ppc/snd_ps3*
 
 PS3VRAM DRIVER
 M:	Jim Paris <jim@jtan.com>
+M:	Geoff Levand <geoff@infradead.org>
+L:	linuxppc-dev@lists.ozlabs.org
 L:	cbe-oss-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/block/ps3vram.c
-- 
2.1.0

Return-Path: <geoff@infradead.org>
Message-Id: <cover.1433959045.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/3] block/ps3vram: Minor updates and fixes
To: Jens Axboe <axboe@kernel.dk>
Cc: Jim Paris <jim@jtan.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2015 18:00:17 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jens,

Here are a few minor updates for the ps3vram driver.  The third patch adds me
as co-maintainer of the driver, which I think is fitting as I have been
maintaining it for the last few years and expect I would be involved in any
future inquiries regarding it.

Please apply, thanks.

-Geoff

The following changes since commit d4a4f75cd8f29cd9464a5a32e9224a91571d6649:

  Linux 4.1-rc7 (2015-06-07 20:23:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-merge-2

for you to fetch changes up to 1d082300a03a735c006739907e6aea082007663c:

  MAINTAINERS: Update ps3vram block driver (2015-06-10 10:46:25 -0700)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      block/ps3vram: Remove obsolete reference to MTD

Geoff Levand (2):
      block/ps3vram: Fix sparse warnings
      MAINTAINERS: Update ps3vram block driver

 MAINTAINERS             |  2 ++
 drivers/block/ps3vram.c | 34 +++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.1.0

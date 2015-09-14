Return-Path: <geoff@infradead.org>
Message-Id: <cover.1442259101.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/3] PS3 updates for 4.3
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 cbe-oss-dev@lists.ozlabs.org, Rudhresh Kumar J <rudhresh.jk@gmail.com>,
 Colin Ian King <colin.king@canonical.com>
Date: Mon, 14 Sep 2015 19:35:04 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few minor updates for PS3.  Please apply.

-Geoff


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-merge-powerpc

for you to fetch changes up to f9c28dfbef66b7f23f1e542397bd6a77d1258ddd:

  powerpc/ps3: Refresh ps3_defconfig (2015-09-14 12:28:10 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      drivers/ps3: Fix ps3-vuart null dereference

Geoff Levand (1):
      powerpc/ps3: Refresh ps3_defconfig

Rudhresh Kumar J (1):
      drivers/ps3: Fix ps3-lpm white space

 arch/powerpc/configs/ps3_defconfig | 4 ----
 drivers/ps3/ps3-lpm.c              | 2 +-
 drivers/ps3/ps3-vuart.c            | 3 +--
 3 files changed, 2 insertions(+), 7 deletions(-)

Colin Ian King (1):
  drivers/ps3: Fix ps3-vuart null dereference

Geoff Levand (1):
  powerpc/ps3: Refresh ps3_defconfig

Rudhresh Kumar J (1):
  drivers/ps3: Fix ps3-lpm white space

 arch/powerpc/configs/ps3_defconfig | 4 ----
 drivers/ps3/ps3-lpm.c              | 2 +-
 drivers/ps3/ps3-vuart.c            | 3 +--
 3 files changed, 2 insertions(+), 7 deletions(-)

-- 
2.1.0

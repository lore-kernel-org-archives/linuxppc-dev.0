Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR7sg68nTzDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 06:09:27 +1000 (AEST)
Message-Id: <cover.1502135910.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/3] Minor updates for PS3
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Jim Paris <jim@jtan.com>,
 Jens Axboe <axboe@kernel.dk>,
 Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 07 Aug 2017 20:09:20 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

A few very minor updates for PS3.  Please apply.

-Geoff

The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e:

  Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-merge-powerpc

for you to fetch changes up to 1c2ef56f08fcfcf74aa281c33363197f8c01e5ab:

  powerpc/ps3: Refresh ps3_defconfig (2017-08-07 12:49:07 -0700)

----------------------------------------------------------------
Geoff Levand (2):
      block/ps3vram: Check return of ps3vram_cache_init
      powerpc/ps3: Refresh ps3_defconfig

Markus Elfring (1):
      block/ps3vram: Delete an error message for a failed memory allocation in ps3vram_cache_init()

 arch/powerpc/configs/ps3_defconfig |  2 --
 drivers/block/ps3vram.c            | 10 ++++++----
 2 files changed, 6 insertions(+), 6 deletions(-)
-- 
2.11.0

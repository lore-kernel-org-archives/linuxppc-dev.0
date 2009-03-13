Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEC51DE10C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 16:20:43 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 13 Mar 2009 16:19:25 +1100
Message-Id: <1236921565.25062.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus !

So here's the new ps3 nvram driver for 2.6.29 that we discussed earlier

Cheers,
Ben.

The following changes since commit 9ead64974b05501bbac0d63a47c99fa786d064ba:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../sam/kbuild-fixes

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Geert Uytterhoeven (1):
      ps3/block: Replace mtd/ps3vram by block/ps3vram

 arch/powerpc/platforms/ps3/Kconfig |    7 +
 drivers/block/Makefile             |    1 +
 drivers/block/ps3vram.c            |  865 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/devices/Kconfig        |    7 -
 drivers/mtd/devices/Makefile       |    1 -
 drivers/mtd/devices/ps3vram.c      |  768 --------------------------------
 6 files changed, 873 insertions(+), 776 deletions(-)
 create mode 100644 drivers/block/ps3vram.c
 delete mode 100644 drivers/mtd/devices/ps3vram.c

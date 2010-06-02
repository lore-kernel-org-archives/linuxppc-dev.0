Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D07EB7D4C
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 18:05:38 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 18:05:28 +1000
Message-ID: <1275465928.1931.780.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here's a reasonably urgent few bug fixes on top of -rc1. Grant OF stuff had
a few issues that broke pretty much all PowerMacs, so this fixes it, along
with a couple of misc fixes and a MAINTAINERS update.

Cheers,
Ben. 

The following changes since commit aef4b9aaae1decc775778903922bd0075cce7a88:
  Linus Torvalds (1):
        Merge branch 'next' of git://git.kernel.org/.../benh/powerpc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Ananth N Mavinakayanahalli (1):
      powerpc/kprobes: Remove resume_execution() in kprobes

Andreas Schwab (1):
      powerpc/macio: Don't dereference pointer before null check

Benjamin Herrenschmidt (1):
      powerpc/macio: Fix probing of macio devices by using the right of match table

Denis Kirjanov (1):
      powerpc/cell: Fix integer constant warning

Olof Johansson (1):
      powerpc/pasemi: Update MAINTAINERS file

Paul Mackerras (1):
      agp/uninorth: Fix oops caused by flushing too much

 MAINTAINERS                            |    3 +--
 arch/powerpc/include/asm/macio.h       |    4 ----
 arch/powerpc/kernel/kprobes.c          |   14 ++------------
 arch/powerpc/platforms/cell/iommu.c    |    2 +-
 drivers/ata/pata_macio.c               |   10 +++++-----
 drivers/block/swim3.c                  |    6 ++++--
 drivers/char/agp/uninorth-agp.c        |    2 +-
 drivers/ide/pmac.c                     |    7 +++++--
 drivers/macintosh/macio_asic.c         |    8 ++++----
 drivers/macintosh/mediabay.c           |    6 ++++--
 drivers/macintosh/rack-meter.c         |    8 +++++---
 drivers/net/bmac.c                     |    7 +++++--
 drivers/net/mace.c                     |    7 +++++--
 drivers/net/wireless/orinoco/airport.c |    7 +++++--
 drivers/scsi/mac53c94.c                |    7 +++++--
 drivers/scsi/mesh.c                    |    7 +++++--
 drivers/serial/pmac_zilog.c            |    7 +++++--
 sound/aoa/soundbus/i2sbus/core.c       |    8 +++++---
 18 files changed, 67 insertions(+), 53 deletions(-)

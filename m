Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D00561007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 17:22:56 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Jul 2010 17:22:43 +1000
Message-ID: <1279092163.28659.464.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@arm.linux.org.uk>,
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

Here are some late fixed for some freescale embedded platforms
for 2.6.35. A bit late but since it only touch their platform
code I don't really have an objection.

Cheers,
Ben.

The following changes since commit 1c5474a65bf15a4cb162dfff86d6d0b5a08a740c:
  Linus Torvalds (1):
        Linux 2.6.35-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Vorontsov (3):
      powerpc/cpm: Reintroduce global spi_pram struct (fixes build issue)
      powerpc/cpm1: Fix build with various CONFIG_*_UCODE_PATCH combinations
      powerpc/cpm1: Mark micropatch code/data static and __init

Matthew McClintock (1):
      powerpc/fsl-booke: Fix address issue when using relocatable kernels

 arch/powerpc/include/asm/cpm.h                |   24 ++++++++++++++++++++
 arch/powerpc/include/asm/cpm1.h               |    3 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |    4 +--
 arch/powerpc/sysdev/micropatch.c              |   30 +++++++++++++++----------
 drivers/spi/spi_mpc8xxx.c                     |   22 ------------------
 5 files changed, 45 insertions(+), 38 deletions(-)

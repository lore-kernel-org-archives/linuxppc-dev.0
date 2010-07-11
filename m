Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2612B6F3E
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 02:18:51 +1000 (EST)
Date: Sun, 11 Jul 2010 11:18:46 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <Pine.LNX.4.64.1007111117290.25465@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* a few build fixes and a bug fix for 2.6.35

The following changes since
commit e467e104bb7482170b79f516d2025e7cfcaaa733:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../roland/infiniband

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

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

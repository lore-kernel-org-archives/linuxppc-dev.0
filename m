Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69108B716B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 07:51:50 +1000 (EST)
Date: Tue, 31 Aug 2010 16:51:40 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <Pine.LNX.4.64.1008311651180.5851@localhost.localdomain>
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

The following changes since commit 54a834043314c257210db2a9d59f8cc605571639:
  Michael Neuling (1):
        powerpc: Don't use kernel stack with translation off

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git ..BRANCH.NOT.VERIFIED..

Alexander Graf (1):
      powerpc/85xx: Fix compilation of mpc85xx_mds.c

Anton Vorontsov (1):
      powerpc/85xx: Add P1021 PCI IDs and quirks

Julia Lawall (2):
      arch/powerpc/platforms/83xx/mpc837x_mds.c: Add missing iounmap
      arch/powerpc/sysdev/qe_lib/qe.c: Add of_node_put to avoid memory leak

Kumar Gala (1):
      powerpc/85xx: Fix compile issue with p1022_ds due to lmb rename to memblock

Li Yang (1):
      fsl_rio: fix compile errors

 arch/powerpc/platforms/83xx/mpc837x_mds.c |    9 ++++++---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 arch/powerpc/platforms/85xx/p1022_ds.c    |    4 ++--
 arch/powerpc/sysdev/fsl_pci.c             |    2 ++
 arch/powerpc/sysdev/fsl_rio.c             |    6 +++++-
 arch/powerpc/sysdev/qe_lib/qe.c           |    1 +
 include/linux/pci_ids.h                   |    2 ++
 7 files changed, 19 insertions(+), 6 deletions(-)

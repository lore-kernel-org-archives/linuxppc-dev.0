Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPSnH0cgxzF0ZV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jan 2018 19:45:22 +1100 (AEDT)
Date: Sun, 21 Jan 2018 01:55:51 -0600
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20180121075456.3knaw4imnsl77jaa@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Contains fixes for CPM GPIO and an FSL PCI erratum workaround,
plus a minor cleanup patch.

The following changes since commit f2ac428e0edabbca41b9dfe9473a90147962e4e9:

  powerpc/pseries/cpuidle: add polling idle for shared processor guests (2018-01-18 15:43:44 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to c095ff93f901c1620b28dce4d813dd548bc5236b:

  powerpc/sysdev: change CPM GPIO to platform_device (2018-01-20 23:29:02 -0600)

----------------------------------------------------------------
Christophe Leroy (1):
      powerpc/sysdev: change CPM GPIO to platform_device

Joakim Tjernlund (1):
      powerpc/fsl_pci: Correct fsl_pci_mcheck_exception

Vasyl Gomonovych (1):
      powerpc/fsl_pci: Fix ptr_ret.cocci warnings

 arch/powerpc/include/asm/cpm.h   |  2 +-
 arch/powerpc/include/asm/cpm1.h  |  2 +
 arch/powerpc/sysdev/Makefile     |  3 +-
 arch/powerpc/sysdev/cpm1.c       | 33 ++++-------------
 arch/powerpc/sysdev/cpm2.c       | 11 ------
 arch/powerpc/sysdev/cpm_common.c |  5 ++-
 arch/powerpc/sysdev/cpm_gpio.c   | 80 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.c    |  6 +--
 8 files changed, 99 insertions(+), 43 deletions(-)
 create mode 100644 arch/powerpc/sysdev/cpm_gpio.c

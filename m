Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r80MG31L5zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 11:37:46 +1000 (AEST)
Date: Mon, 16 May 2016 20:37:40 -0500
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20160517013740.GA18846@home.buserror.net>
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

Sorry for the lateness...

Contains include 86xx fixes, minor device tree fixes, an erratum
workaround, and a kconfig dependency fix.

The following changes since commit 1d4e89cf0a4e819fbde428e9e5286e7141a02e06:

  powerpc/powernv/npu: Add PE to PHB's list (2016-05-12 19:56:25 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 1eef33bec12d7e46a58f12b3604556a80c362a0d:

  powerpc/86xx: Fix PCI interrupt map definition (2016-05-16 18:45:39 -0500)

----------------------------------------------------------------
Alessio Igor Bogani (3):
      powerpc/fsl: Fix build of the dtb embedded kernel images
      powerpc/86xx: Move pci1 definition to the include file
      powerpc/86xx: Fix PCI interrupt map definition

Chenhui Zhao (1):
      powerpc/fsl: Fix rcpm compatible string

Hou Zhiqiang (1):
      powerpc/fsl: Fix SPI compatible on t208xrdb and t1040rdb

Scott Wood (1):
      powerpc/fsl: Remove FSL_SOC dependency from FSL_LBC

chenhui zhao (1):
      powerpc/fsl-pci: Add a workaround for PCI 5 errata

 arch/powerpc/Kconfig                           |  1 -
 arch/powerpc/boot/Makefile                     |  6 ++--
 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts        |  4 +++
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 22 --------------
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts       |  4 +++
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 24 +--------------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 24 +--------------
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi  | 41 +++++++++++++++++++++-----
 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi   |  1 +
 arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 23 ---------------
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi    |  2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi    |  2 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi        |  2 +-
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi        |  2 +-
 arch/powerpc/sysdev/fsl_pci.c                  | 24 +++++++++++++++
 15 files changed, 76 insertions(+), 106 deletions(-)

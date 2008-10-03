Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.243])
	by ozlabs.org (Postfix) with ESMTP id BCBA8DE078
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 22:31:43 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so509592hsz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Oct 2008 05:31:42 -0700 (PDT)
Date: Fri, 3 Oct 2008 08:30:28 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20081003123028.GE2229@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Here's the pull request for my current set of patches.  I might have a
few more later, but lets get these in now.

josh

The following changes since commit 1afb7f809bfb8fad9eec9419f3dfd75cee746ebd:
  Paul Mackerras (1):
        Merge branch 'powerpc-next' of master.kernel.org:/.../galak/powerpc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Josh Boyer (3):
      ibm_newemac: Allow the "no flow control" EMAC feature to work
      ibm_newemac: Introduce mal_has_feature
      ibm_newemac: MAL support for PowerPC 405EZ

Matthias Fuchs (1):
      powerpc/4xx: Allow 4xx PCI bridge to be disabled via device tree

Victor Gallardo (4):
      ibm_newemac: Add support for GPCS, SGMII and M88E1112 PHY
      powerpc/44x: Add AMCC Arches eval board support
      powerpc/44x: Add AMCC Arches DTS
      powerpc/44x: Add AMCC Arches defconfig file

 arch/powerpc/boot/dts/arches.dts           |  293 +++++++++++
 arch/powerpc/configs/44x/arches_defconfig  |  767 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/dcr-regs.h        |   11 +
 arch/powerpc/platforms/44x/Kconfig         |   17 +-
 arch/powerpc/platforms/44x/ppc44x_simple.c |    3 +-
 arch/powerpc/sysdev/ppc4xx_pci.c           |    9 +-
 drivers/net/ibm_newemac/Kconfig            |   12 +
 drivers/net/ibm_newemac/core.c             |   60 ++-
 drivers/net/ibm_newemac/core.h             |   11 +
 drivers/net/ibm_newemac/mal.c              |   60 ++-
 drivers/net/ibm_newemac/mal.h              |   34 ++
 drivers/net/ibm_newemac/phy.c              |   84 +++
 drivers/net/ibm_newemac/phy.h              |    2 +
 13 files changed, 1345 insertions(+), 18 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/arches.dts
 create mode 100644 arch/powerpc/configs/44x/arches_defconfig

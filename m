Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56322DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 22:26:42 +1000 (EST)
Date: Tue, 5 May 2009 07:26:34 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'pci' branch into 'test'
Message-ID: <Pine.LNX.4.64.0905050721500.18785@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Here are various pci related changes for 2.6.31 that can look at going
into your test tree to see if they break anyone.  It would be nice if this
could get some testing on pseries by one of you guys as I have no access
to such HW.

- k

Please pull from 'pci' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git pci

to receive the following updates:

 arch/powerpc/include/asm/pci-bridge.h          |    7 ------
 arch/powerpc/kernel/pci_32.c                   |   19 ----------------
 arch/powerpc/kernel/pci_64.c                   |   10 --------
 arch/powerpc/kernel/pci_dn.c                   |   28 -------------------------
 arch/powerpc/kernel/rtas_pci.c                 |   10 +-------
 arch/powerpc/platforms/52xx/efika.c            |    4 +--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c      |    4 +--
 arch/powerpc/platforms/cell/celleb_pci.c       |   10 +-------
 arch/powerpc/platforms/cell/celleb_scc_epci.c  |   13 +----------
 arch/powerpc/platforms/cell/celleb_scc_pciex.c |   12 +---------
 arch/powerpc/platforms/chrp/pci.c              |    8 +++----
 arch/powerpc/platforms/iseries/pci.c           |    8 +++----
 arch/powerpc/platforms/powermac/setup.c        |    2 -
 arch/powerpc/platforms/pseries/setup.c         |   25 ++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.c                  |    6 ++---
 arch/powerpc/sysdev/indirect_pci.c             |    4 +--
 arch/powerpc/sysdev/ppc4xx_pci.c               |    4 +--
 arch/powerpc/sysdev/tsi108_pci.c               |    4 +--
 drivers/pci/Makefile                           |    1
 19 files changed, 57 insertions(+), 122 deletions(-)

Kumar Gala (13):
      powerpc/pci: clean up direct access to sysdata by indirect ops
      powerpc/pci: clean up direct access to sysdata by FSL platforms
      powerpc/pci: clean up direct access to sysdata by 52xx platforms
      powerpc/pci: clean up direct access to sysdata by 4xx platforms
      powerpc/pci: clean up direct access to sysdata by CHRP platforms
      powerpc/pci: clean up direct access to sysdata on tsi108 platforms
      powerpc/pci: clean up direct access to sysdata by powermac platforms
      powerpc/pci: clean up direct access to sysdata by RTAS
      powerpc/pci: clean up direct access to sysdata by celleb platforms
      powerpc/pci: clean up direct access to sysdata by iseries platform
      powerpc/pci: Move pseries code into pseries platform specific area
      powerpc/pci: cleanup some minor cruft
      powerpc/pci: Remove redundant pcnet32 fixup

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6141F2C00BE
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2012 23:28:55 +1000 (EST)
Date: Wed, 3 Oct 2012 08:25:23 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1210030824340.5186@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

A few minor patches for v3.7.

The following changes since commit 7844663a31e97930e3949430573452ac245bfdd5:

  powerpc/eeh: Don't release eeh_mutex in eeh_phb_pe_get (2012-09-27 12:51:07 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

for you to fetch changes up to 10bfa766efa19c23f72f50727952a26cb1512256:

  driver/mtd:IFC NAND:Initialise internal SRAM before any write (2012-09-27 07:32:25 -0500)

----------------------------------------------------------------
Minghuan Lian (1):
      powerpc/fsl-pci: use 'Header Type' to identify PCIE mode

Prabhakar Kushwaha (1):
      driver/mtd:IFC NAND:Initialise internal SRAM before any write

 arch/powerpc/sysdev/fsl_pci.c   |   37 +++++++++++++++++---------
 drivers/mtd/nand/fsl_ifc_nand.c |   56 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 14 deletions(-)

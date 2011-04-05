Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04118B6FA9
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 14:31:04 +1000 (EST)
Date: Mon, 4 Apr 2011 23:30:58 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1104042330380.19519@right.am.freescale.net>
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

The following changes since commit c0bb9e45f3a7f67fc358946727bc3d5f23d0f55d:

  kdump: Allow shrinking of kdump region to be overridden (2011-04-01 16:14:30 +1100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (1):
      edac/mpc85xx: Limit setting/clearing of HID1[RFXE] to e500v1/v2 cores

Prabhakar Kushwaha (1):
      powerpc/85xx: Update dts for PCIe memory maps to match u-boot of Px020RDB

 arch/powerpc/boot/dts/p1020rdb.dts            |   12 +++++-----
 arch/powerpc/boot/dts/p2020rdb.dts            |   12 +++++-----
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    4 +-
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |   10 ++++----
 drivers/edac/mpc85xx_edac.c                   |   27 +++++++++++++++++-------
 5 files changed, 38 insertions(+), 27 deletions(-)

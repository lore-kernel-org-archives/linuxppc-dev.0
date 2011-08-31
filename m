Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96FFAB6F7F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 13:14:12 +1000 (EST)
Date: Tue, 30 Aug 2011 22:14:04 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1108302213080.19634@right.am.freescale.net>
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

Ben,

A few minor defconfig updates and a dts fix to send up to Linus for 3.1

- k

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Chunhe Lan (1):
      powerpc/p1023rds: Fix the error of bank-width of nor flash

Kim Phillips (1):
      powerpc/85xx: enable caam crypto driver by default

Timur Tabi (1):
      powerpc/85xx: enable the audio drivers in the defconfigs

 arch/powerpc/boot/dts/p1023rds.dts           |    2 +-
 arch/powerpc/configs/85xx/p1023rds_defconfig |    1 +
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    5 ++++-
 arch/powerpc/configs/mpc85xx_defconfig       |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
 6 files changed, 9 insertions(+), 2 deletions(-)

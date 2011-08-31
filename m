Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB338B6F7B
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 16:10:44 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 31 Aug 2011 16:10:02 +1000
Message-ID: <1314771002.2488.138.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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

Here are some minor defconfig updates and a device tree fix from
Kumar for 3.1.

Cheers,
Ben.

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

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

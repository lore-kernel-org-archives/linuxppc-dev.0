Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF38DB6F5A
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 18:14:00 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 18:13:22 +1000
Message-ID: <1309335202.14501.67.camel@pasglop>
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

Here are a handful of minor powerpc bits for 3.0

Note: At the time of this sending, the mirrors still hadn't caught up.

Cheers,
Ben.


The following changes since commit b0af8dfdd67699e25083478c63eedef2e72ebd85:

  Linux 3.0-rc5 (2011-06-27 19:12:22 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Christian Dietrich (2):
      powerpc/rtas-rtc: remove sideeffects of printk_ratelimit
      arch/powerpc: use printk_ratelimited instead of printk_ratelimit

Michael Neuling (1):
      powerpc/pseries: remove duplicate SCSI_BNX2_ISCSI in pseries_defconfig

Scott Wood (1):
      powerpc/e500: fix breakage with fsl_rio_mcheck_exception

Shaohui Xie (1):
      powerpc/85xx: fix NAND_CMD_READID read bytes number

Timur Tabi (1):
      powerpc/p1022ds: fix audio-related properties in the device tree

 arch/powerpc/boot/dts/p1022ds.dts      |    9 +++--
 arch/powerpc/configs/pseries_defconfig |    1 -
 arch/powerpc/kernel/rtas-rtc.c         |   29 +++++++++-------
 arch/powerpc/kernel/signal_32.c        |   57 +++++++++++++++++--------------
 arch/powerpc/kernel/signal_64.c        |   17 +++++----
 arch/powerpc/kernel/traps.c            |   24 ++++++-------
 arch/powerpc/mm/fault.c                |   10 +++---
 arch/powerpc/sysdev/fsl_rio.c          |   33 +++++++++---------
 arch/powerpc/sysdev/mpic.c             |   11 +++---
 drivers/mtd/nand/fsl_elbc_nand.c       |    6 ++--
 10 files changed, 104 insertions(+), 93 deletions(-)

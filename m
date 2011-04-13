Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71645B6F53
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 14:26:54 +1000 (EST)
Date: Tue, 12 Apr 2011 23:26:47 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1104122326260.29282@right.am.freescale.net>
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

The following changes since commit c60e65d7863620945d498a8ac60181077879599c:

  powerpc/pseries: Fix build without CONFIG_HOTPLUG_CPU (2011-04-05 16:22:11 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (2):
      powerpc/book3e: Fix CPU feature handling on 64-bit e5500
      powerpc/85xx: disable Suspend support if SMP enabled

Prabhakar Kushwaha (2):
      powerpc/85xx: Don't add disabled PCIe devices
      powerpc: Check device status before adding serial device

Scott Wood (1):
      powerpc/e500mc: Remove CPU_FTR_MAYBE_CAN_NAP/CPU_FTR_MAYBE_CAN_DOZE

 arch/powerpc/Kconfig                |    2 +-
 arch/powerpc/include/asm/cputable.h |   16 ++++++++++++++--
 arch/powerpc/kernel/cputable.c      |    2 +-
 arch/powerpc/kernel/legacy_serial.c |    8 +++++---
 arch/powerpc/sysdev/fsl_pci.c       |    5 +++++
 5 files changed, 26 insertions(+), 7 deletions(-)

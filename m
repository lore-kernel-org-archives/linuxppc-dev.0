Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 59AA3B6FC2
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2012 11:44:54 +1000 (EST)
Message-ID: <1335750286.20866.25.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Apr 2012 11:44:46 +1000
Content-Type: text/plain; charset="UTF-8"
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

Here are a handful more fixes for powerpc. The irq stuff are all
regression fixes, and Gavin's patch is a simple compile fix.

Cheers,
Ben.

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 810b4de25e53459323ff48957b0162b48d6cbd57:

  tty/serial/pmac_zilog: Fix "nobody cared" IRQ message (2012-04-30 10:59:58 +1000)

----------------------------------------------------------------
Gavin Shan (1):
      powerpc/pseries: Rivet CONFIG_EEH for pSeries platform

Grant Likely (2):
      powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx interrupt controller
      powerpc/irqdomain: Fix broken NR_IRQ references

Larry Finger (1):
      tty/serial/pmac_zilog: Fix "nobody cared" IRQ message

 arch/powerpc/include/asm/irq.h               |    4 --
 arch/powerpc/kernel/irq.c                    |    6 +--
 arch/powerpc/kernel/machine_kexec.c          |    7 +--
 arch/powerpc/platforms/cell/axon_msi.c       |    8 ++--
 arch/powerpc/platforms/cell/beat_interrupt.c |    2 +-
 arch/powerpc/platforms/powermac/pic.c        |    6 +--
 arch/powerpc/platforms/pseries/Kconfig       |    4 +-
 arch/powerpc/sysdev/cpm2_pic.c               |    3 +-
 arch/powerpc/sysdev/mpc8xx_pic.c             |   61 +++++++++-----------------
 arch/powerpc/sysdev/xics/xics-common.c       |    7 ++-
 drivers/tty/serial/pmac_zilog.c              |    6 +--
 11 files changed, 39 insertions(+), 75 deletions(-)

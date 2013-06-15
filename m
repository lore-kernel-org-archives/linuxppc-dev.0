Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EB04F2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 13:11:11 +1000 (EST)
Message-ID: <1371265846.21896.29.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 15 Jun 2013 13:10:46 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Hopefully this one smells better ...

So here are 3 fixes still for 3.10. Fixes are simple, bugs are nasty
(though not recent regressions, nasty enough) and all targeted at
stable. Please apply.

Thanks !

Cheers,
Ben.

The following changes since commit 34376a50fb1fa095b9d0636fa41ed2e73125f214:

  Fix lockup related to stop_machine being stuck in __do_softirq. (2013-06-10 17:46:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 230b3034793247f61e6a0b08c44cf415f6d92981:

  powerpc: Fix missing/delayed calls to irq_work (2013-06-15 12:33:30 +1000)

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc: Fix missing/delayed calls to irq_work

Michael Ellerman (1):
      powerpc: Fix stack overflow crash in resume_kernel when ftracing

Paul Mackerras (1):
      powerpc: Fix emulation of illegal instructions on PowerNV platform

 arch/powerpc/include/asm/exception-64s.h |    2 +-
 arch/powerpc/kernel/exceptions-64s.S     |    2 +-
 arch/powerpc/kernel/irq.c                |    2 +-
 arch/powerpc/kernel/process.c            |    4 ++--
 arch/powerpc/kernel/traps.c              |   10 ++++++++++
 5 files changed, 15 insertions(+), 5 deletions(-)

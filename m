Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D84D9B6F6E
 for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2012 11:12:17 +1000 (EST)
Message-ID: <1336525930.1714.3.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 09 May 2012 11:12:10 +1000
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

Here are a couple of last minute fixes for 3.4 for regressions
introduced by my rewrite of the lazy irq masking code.

Cheers,
Ben.

The following changes since commit 810b4de25e53459323ff48957b0162b48d6cbd57:

  tty/serial/pmac_zilog: Fix "nobody cared" IRQ message (2012-04-30 10:59:58 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to a3512b2dd57cb653bb33645ca9c934436e547e3c:

  powerpc/irq: Make alignment & program interrupt behave the same (2012-05-09 09:42:33 +1000)

----------------------------------------------------------------
Benjamin Herrenschmidt (2):
      powerpc/irq: Fix bug with new lazy IRQ handling code
      powerpc/irq: Make alignment & program interrupt behave the same

 arch/powerpc/include/asm/exception-64s.h |    7 -------
 arch/powerpc/kernel/entry_64.S           |   18 ------------------
 arch/powerpc/kernel/exceptions-64s.S     |    2 +-
 arch/powerpc/kernel/irq.c                |    8 +++++++-
 arch/powerpc/kernel/traps.c              |   10 ++++++++--
 5 files changed, 16 insertions(+), 29 deletions(-)

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9CD6B2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 08:05:05 +1100 (EST)
Message-ID: <1394226295.14642.28.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 08 Mar 2014 08:04:55 +1100
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

Here are a couple of powerpc fixes for 3.14. One is (another !) nasty TM
problem, we can crash the kernel by forking inside a transaction. The
other one is a simple fix for an alignment issue which can hurt in LE
mode.

Cheers,
Ben.

The following changes since commit e0cf957614976896111e676e5134ac98ee227d3d:

  powerpc/powernv: Fix indirect XSCOM unmangling (2014-02-28 19:15:49 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to a5b2cf5b1af424ee3dd9e3ce6d5cea18cb927e67:

  powerpc: Align p_dyn, p_rela and p_st symbols (2014-03-07 13:50:19 +1100)

----------------------------------------------------------------
Anton Blanchard (1):
      powerpc: Align p_dyn, p_rela and p_st symbols

Michael Neuling (1):
      powerpc/tm: Fix crash when forking inside a transaction

 arch/powerpc/kernel/process.c  | 9 +++++++++
 arch/powerpc/kernel/reloc_64.S | 1 +
 2 files changed, 10 insertions(+)

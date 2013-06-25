Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5E73A2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 17:53:40 +1000 (EST)
Message-ID: <1372146812.3944.198.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Jun 2013 17:53:32 +1000
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

This is a fix for a regression causing a freescale "83xx" based platforms
to crash on boot due to some PCI breakage. Please apply.

Cheers,
Ben.

The following changes since commit 17858ca65eef148d335ffd4cfc09228a1c1cbfb5:

  Merge tag 'please-pull-fixia64' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2013-06-18 06:29:19 -1000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to b37e161388ac3980d5dfb73050e85874b84253eb:

  powerpc/pci: Fix boot panic on mpc83xx (regression) (2013-06-24 16:54:09 -0500)

----------------------------------------------------------------
Rojhalat Ibrahim (1):
      powerpc/pci: Fix boot panic on mpc83xx (regression)

 arch/powerpc/sysdev/fsl_pci.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

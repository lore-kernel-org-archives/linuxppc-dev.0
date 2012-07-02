Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3EEFB2C01BA
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2012 14:57:47 +1000 (EST)
Message-ID: <1341205059.2588.30.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 02 Jul 2012 14:57:39 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus 

Here are two more fixes that I "missed" when scrubbing patchwork last
week which are worth still having in 3.5.

Cheers,
Ben.

The following changes since commit bc6dc752f35488160ffac07ae91bed1bddaea32a:

  powerpc/pseries: Fix software invalidate TCE (2012-06-29 14:35:37 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 2f584a146a2965b82fce89b8d2f95dc5cfe468d0:

  powerpc/kvm: sldi should be sld (2012-07-02 14:30:12 +1000)

----------------------------------------------------------------
Anton Blanchard (1):
      powerpc/xmon: Use cpumask iterator to avoid warning

Michael Neuling (1):
      powerpc/kvm: sldi should be sld

 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    2 +-
 arch/powerpc/xmon/xmon.c                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

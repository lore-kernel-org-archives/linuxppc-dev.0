Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57E1BDDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 09:33:57 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 27 Feb 2009 09:33:46 +1100
Message-Id: <1235687626.7388.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus

And here's another little regression fix. For some reason, that one was
done and acked ages ago, marked "accepted" in patchwork and never
actually merged anywhere ... go figure.

The following changes since commit 64e71303e44f3697e4568147caa966de74bdb4fb:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../mason/btrfs-unstable

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      powerpc/44x: Fix address decoding setup of PCI 2.x cells

 arch/powerpc/sysdev/ppc4xx_pci.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

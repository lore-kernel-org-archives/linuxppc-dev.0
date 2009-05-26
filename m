Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04CA8DE0F8
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 13:51:07 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 26 May 2009 13:50:41 +1000
Message-Id: <1243309841.2858.60.camel@pasglop>
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

Hi Linus !

Here's the first of two fixes for nasty brown paper bag bugs that went
in recently and are both my fault (I need to start buying those bags
in bulk I reckon...)

It's 2.6.30 material. I'll send the second one tomorrow or so after a
bit more review and testing happened as it's unfortunately more
invasive.

The following changes since commit b18f1e21993f73f072b1e0859f942fb11afddcb1:
  Linus Torvalds (1):
        Merge branch 'kvm-updates/2.6.30' of git://git.kernel.org/pub/scm/virt/kvm/kvm

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Hideo Saito (1):
      powerpc/mm: Fix broken MMU PID stealing on !SMP

 arch/powerpc/mm/mmu_context_nohash.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

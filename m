Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8CCBEB7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 16:59:04 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5032DDDA0
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 16:59:03 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 16:58:29 +1000
Message-Id: <1249887509.9841.23.camel@pasglop>
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

This is a simple enough fix that I decided was worth having now, it
basically allow "direct" DMA (non-iommu) to work for devices that have a
< 32-bit DMA mask (such as some infamous broadcom wireless chips) when
the machine simply has not enough memory to go over the chip addressing
limit. This fixes various smallish G5 (like old iMac G5) wireless.

The following changes since commit f4b9a988685da6386d7f9a72df3098bcc3270526:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.infradead.org/ubi-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      powerpc/dma: pci_set_dma_mask() shouldn't fail if mask fits in RAM

 arch/powerpc/kernel/dma.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

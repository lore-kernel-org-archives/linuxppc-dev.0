Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF14DDDDAA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 16:16:08 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 16:15:28 +1100
Message-Id: <1234329328.29851.16.camel@pasglop>
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

This is a single patch, to fix a regression introduced in this merge
window. Please apply.

The following changes since commit 1db8508cf483dc1ecf66141f90a7c03659d69512:
  Stefan Richter (1):
        hugetlbfs: fix build failure with !CONFIG_HUGETLBFS

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Kumar Gala (1):
      powerpc/mm: Fix _PAGE_COHERENT support on classic ppc32 HW

 arch/powerpc/mm/hash_low_32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 761061007D7
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 14:06:58 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 14:06:18 +1000
Message-ID: <1305777978.7481.37.camel@pasglop>
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

Hi Linus

Dunno if it's too late or not yet but here's 3 fixes for powerpc that
would be welcome to have in before the release. If not I'll send them
first thing next (one of them is already in -next in fact).

Those are regression fixes and a build breakage.

Cheers,
Ben.

The following changes since commit fce519588acfac249e8fdc1f5016c73d617de315:

  Merge branch 'devicetree/merge' of git://git.secretlab.ca/git/linux-2.6 (2011-05-18 13:25:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Ben Hutchings (1):
      powerpc/kexec: Fix build failure on 32-bit SMP

Benjamin Herrenschmidt (1):
      powerpc/smp: Make start_secondary_resume available to all CPU variants

kerstin jonsson (1):
      powerpc/4xx: Fix regression in SMP on 476

 arch/powerpc/kernel/crash.c   |   59 +++++++++++++++++++++--------------------
 arch/powerpc/kernel/head_32.S |    9 ------
 arch/powerpc/kernel/misc_32.S |   11 +++++++
 arch/powerpc/kernel/smp.c     |    4 +-
 4 files changed, 43 insertions(+), 40 deletions(-)

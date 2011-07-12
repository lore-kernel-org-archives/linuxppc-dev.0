Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4EEAB6F74
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 11:27:01 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jul 2011 11:26:21 +1000
Message-ID: <1310433981.4968.19.camel@pasglop>
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

I almost forgot to send you these two patches I had around for some time
now. They fix a nasty warning at boot (and possibly more) when booting a
kernel with CONFIG_PPC_PSERIES enabled on a non-pseries machine.

The first patch just moves a duplicate #define to a common header file,
the second patch is the actual fix.

Cheers,
Ben.

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (2):
      mm: Move definition of MIN_MEMORY_BLOCK_SIZE to a header
      powerpc/mm: Fix memory_block_size_bytes() for non-pseries

 arch/powerpc/platforms/pseries/hotplug-memory.c |   30 ++++++++++++++--------
 arch/x86/mm/init_64.c                           |    3 +-
 drivers/base/memory.c                           |    1 -
 include/linux/memory.h                          |    2 +
 4 files changed, 22 insertions(+), 14 deletions(-)
 

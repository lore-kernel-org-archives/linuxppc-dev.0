Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F19E2C0082
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2012 09:07:38 +1100 (EST)
Message-ID: <1353881249.16666.4.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Nov 2012 09:07:29 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
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

Here's a patch that would be good to still have in 3.7. It's a one liner fixing
a regression introduced by the new EEH code in .37 (potential oops on some
PCI setups when configuring MSIs).

Cheers,
Ben.

The following changes since commit d6dc24613c222f9057131ccbd5264a10bcba9f97:

  Merge remote-tracking branch 'agust/merge' into merge (2012-11-21 13:24:49 +1100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git 

for you to fetch changes up to bb4618823a3389086f157fafb2a0d97cade8d89f:

  powerpc/pseries: Fix oops with MSIs when missing EEH PEs (2012-11-23 13:26:05 +1100)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/pseries: Fix oops with MSIs when missing EEH PEs

 arch/powerpc/platforms/pseries/msi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 736DCDDF2E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 03:09:04 +1100 (EST)
Date: Wed, 17 Dec 2008 10:08:25 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'merge' for 2.6.28
Message-ID: <Pine.LNX.4.64.0812171006580.12026@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following changes since commit 23e0e8afafd9ac065d81506524adf3339584044b:
  Arnd Bergmann (1):
        powerpc/cell/axon-msi: Fix MSI after kexec

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

Dave Liu (1):
      powerpc/fsl-booke: Fix the miss interrupt restore

Guillaume Knispel (1):
      powerpc: Fix corruption error in rh_alloc_fixed()

 arch/powerpc/kernel/misc_32.S |    4 ++--
 arch/powerpc/lib/rheap.c      |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

--

Dave's patch fixes a stupid issue I introduced with my previous commit and
Guillaume is a simple fix for some oops's he was seeing.

- k

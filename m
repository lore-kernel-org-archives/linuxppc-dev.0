Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0ABFCDDF4B
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 10:39:41 +1100 (EST)
Date: Sat, 13 Dec 2008 17:39:01 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'merge' for 2.6.28
Message-ID: <Pine.LNX.4.64.0812131735290.5685@blarg.am.freescale.net>
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

The following changes since commit ab44f4627e2160cddbddbe8aa8b1d2b2e1559790:
  Paul Mackerras (1):
        Merge branch 'merge' of master.kernel.org:/.../galak/powerpc into merge

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (1):
      powerpc/fsl-booke: Fix problem with _tlbil_va being interrupted

 arch/powerpc/kernel/misc_32.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

--

Commit 0ba3418b8b1c85ee1771c63f1dd12041614e56ff that went into 2.6.28
introduced the bug that this patch fixes.

- k

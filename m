Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AC84B7D4E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 16:52:15 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o2H5qBUM005139
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 00:52:11 -0500
Date: Wed, 17 Mar 2010 00:52:11 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [git pull] Please pull powerpc.git merge branch (fwd)
Message-ID: <Pine.LNX.4.64.1003170052001.14591@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

forgot to cc the list

---------- Forwarded message ----------
Date: Wed, 17 Mar 2010 00:13:00 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch

The following changes since commit 30124d11097e371e42052144d8a3f4a78d26e09f:
  Dave Kleikamp (1):
        powerpc/booke: Fix breakpoint/watchpoint one-shot behavior

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (2):
      powerpc/85xx: Make sure lwarx hint isn't set on ppc32
      powerpc/fsl-booke: Get coherent bit from PTE

 arch/powerpc/include/asm/ppc-opcode.h |    6 +++---
 arch/powerpc/kernel/head_fsl_booke.S  |    3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

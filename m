Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F10A9B70A9
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2011 09:22:03 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/3] powerpc: Backport 8xx TLB to 2.4, part2
Date: Thu, 13 Jan 2011 23:21:52 +0100
Message-Id: <1294957315-1696-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Did some minor cleanup and fixed a small bug.
Resending the "Move invalidation of non present TLBs" patch
properly.

Joakim Tjernlund (3):
  8xx: Move invalidation of non present TLBs
  8xx: Use symbolic constants in TLB asm
  8xx: Set correct HW pte flags in DTLB Error too

 arch/ppc/kernel/head_8xx.S |   31 ++++++++++++++++++++++---------
 arch/ppc/mm/fault.c        |    7 -------
 2 files changed, 22 insertions(+), 16 deletions(-)

-- 
1.7.3.4

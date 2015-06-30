Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 3D9C01A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 23:56:39 +1000 (AEST)
Message-Id: <cover.1435655732.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/2] powerpc32: Optimise csum_partial()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 30 Jun 2015 15:56:36 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The purpose of this patchset is to optimise csum_partial() on powerpc32.
In the first part, we remove some unneccessary instructions
In the second part, we partially unloop the main loop

Christophe Leroy (2):
  Optimise a few instructions in csum_partial()
  Optimise csum_partial() loop

 arch/powerpc/lib/checksum_32.S | 53 +++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

-- 
2.1.0

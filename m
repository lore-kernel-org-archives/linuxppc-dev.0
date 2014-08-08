Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 1F6B41A0455
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 17:04:07 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 00/20] powerpc/8xx: Optimise MMU TLB handling and add support
 of 16k pages
Message-Id: <20140808070339.48C4D1ABCF0@localhost.localdomain>
Date: Fri,  8 Aug 2014 09:03:38 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset:
* provides several MMU TLB handling optimisation on MPC8xx.
* adds support of 16k pages on MPC8xx.
All changes have been successfully tested on a custom board equipped with MPC885

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

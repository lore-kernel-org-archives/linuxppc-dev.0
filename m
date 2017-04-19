Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MSx5G1nzDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:56:33 +1000 (AEST)
Message-Id: <cover.1492606297.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/5] powerpc/mm: some cleanup of do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Apr 2017 14:56:22 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset is a split of previous patch called the same way as
this summary. Comments from Michael are taken into account.

Christophe Leroy (5):
  powerpc/mm: only call store_updates_sp() on stores in do_page_fault()
  powerpc/mm: split store_updates_sp() in two parts in do_page_fault()
  powerpc/mm: remove a redundant test in do_page_fault()
  powerpc/mm: Evaluate user_mode(regs) only once in do_page_fault()
  powerpc/mm: The 8xx doesn't call do_page_fault() for breakpoints

 arch/powerpc/mm/fault.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

-- 
2.12.0

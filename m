Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38A791A0194
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:56:43 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/4] powerpc: trivial unused functions cleanup
Date: Mon, 16 Feb 2015 17:56:24 +0700
Message-Id: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, Arseny Solokha <asolokha@kb.kras.ru>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series removes unused functions from powerpc tree that I've been
able to discover.

Arseny Solokha (4):
  powerpc/boot: drop planetcore_set_serial_speed
  kvm/ppc/mpic: drop unused IRQ_testbit
  powrepc/qe: drop unused ucc_slow_poll_transmitter_now
  powerpc/mpic: remove unused functions

 arch/powerpc/boot/planetcore.c        | 33 ---------------------------------
 arch/powerpc/boot/planetcore.h        |  3 ---
 arch/powerpc/include/asm/mpic.h       | 16 ----------------
 arch/powerpc/include/asm/ucc_slow.h   | 13 -------------
 arch/powerpc/kvm/mpic.c               |  5 -----
 arch/powerpc/sysdev/mpic.c            | 35 -----------------------------------
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |  5 -----
 7 files changed, 110 deletions(-)

-- 
2.3.0

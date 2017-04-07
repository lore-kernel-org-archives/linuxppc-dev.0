Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzhlv1ZMhzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 11:27:55 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id g2so11625087pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 18:27:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] more facility bit additions for POWER9
Date: Fri,  7 Apr 2017 11:27:42 +1000
Message-Id: <20170407012744.21800-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No real change except add register definitions and facility
unavailable type names.

Nicholas Piggin (2):
  powerpc/64s: Add msgp facility unavailable log string
  powerpc/64s: Add SCV FSCR bit for ISA v3.0

 arch/powerpc/include/asm/reg.h |  2 ++
 arch/powerpc/kernel/traps.c    | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.11.0

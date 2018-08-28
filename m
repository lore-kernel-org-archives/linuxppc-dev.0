Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420FLG5B7MzDrTH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 02:57:42 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id k19-v6so993756pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 09:57:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3] misc SLB patches
Date: Wed, 29 Aug 2018 02:57:28 +1000
Message-Id: <20180828165731.24320-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are a few bits and pieces I collected I'll get out of the
way ahead of the SLB rewrite in C patch and subsequent improvements.

Nicholas Piggin (3):
  powerpc/64s/hash: Fix stab_rr off by one initialization
  powerpc/64s/hash: Use POWER9 SLBIA IH=3 variant in switch_mm
  powerpc/64s/hash: avoid the POWER5 < DD2.1 slb invalidate workaround
    on POWER8/9

 arch/powerpc/kernel/entry_64.S |  2 ++
 arch/powerpc/mm/slb.c          | 58 ++++++++++++++++++++++------------
 arch/powerpc/xmon/xmon.c       | 11 ++++---
 3 files changed, 46 insertions(+), 25 deletions(-)

-- 
2.18.0

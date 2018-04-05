Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GsZ61jMhzF1w1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 15:58:05 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id v18-v6so15718190ply.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 22:58:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/2] a couple of cpu ftrs fixes
Date: Thu,  5 Apr 2018 15:57:53 +1000
Message-Id: <20180405055755.30090-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are a couple of differences between cputable and dt_cpu_ftrs
I noticed with CPU_FTR bits. We have to be a bit careful now to keep
them in sync when we change one or the other.

Nicholas Piggin (2):
  powerpc/64s: Fix pkey support in dt_cpu_ftrs, add CPU_FTR_PKEY bit
  powerpc/64s: Fix POWER9 DD2.2 and above in cputable features

 arch/powerpc/include/asm/cputable.h | 3 ++-
 arch/powerpc/kernel/dt_cpu_ftrs.c   | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.16.3

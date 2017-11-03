Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySpV54LNGzDr8p
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 15:13:33 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 17so1300229pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 21:13:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH v3 0/3] Add POWER9 DD2.0 feature,
 remove idle workarounds in DD2.1
Date: Fri,  3 Nov 2017 15:13:18 +1100
Message-Id: <20171103041321.5113-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since v2: Split up the features into two patches.

I kept Vaidy's reviewed-by because the end result code was not changed.

Nicholas Piggin (3):
  powerpc: add POWER9_DD20 feature
  powerpc/64s/idle: avoid POWER9 DD1 and DD2.0 ERAT workaround on DD2.1
  powerpc/64s/idle: avoid POWER9 DD1 and DD2.0 PMU workaround on DD2.1

 arch/powerpc/include/asm/cputable.h |  5 ++++-
 arch/powerpc/kernel/cputable.c      | 20 ++++++++++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c   |  2 ++
 arch/powerpc/kernel/idle_book3s.S   | 31 ++++++++++++++++++++-----------
 4 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.15.0

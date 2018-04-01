Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DPbd6wrTzF217
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 15:50:53 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id v5-v6so356983plo.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:50:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/2] couple of minor DAWR fixes
Date: Sun,  1 Apr 2018 15:50:34 +1000
Message-Id: <20180401055036.18078-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin (2):
  KVM: PPC: Book3S HV: Fix ppc_breakpoint_available compile error
  powerpc: Fix DABR write in the case of DAWR disabled

 arch/powerpc/kernel/process.c | 13 +++++++++----
 arch/powerpc/kvm/book3s_hv.c  |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.16.3

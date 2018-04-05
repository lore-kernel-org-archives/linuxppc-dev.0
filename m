Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x231.google.com (mail-pl0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H9WJ6btfzF1ql
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 03:56:44 +1000 (AEST)
Received: by mail-pl0-x231.google.com with SMTP id 59-v6so17527493plc.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 10:56:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 0/2] KVM powerpc tlbie scalability improvement
Date: Fri,  6 Apr 2018 03:56:29 +1000
Message-Id: <20180405175631.31381-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any reason we still need to take the tlbie lock on modern
processors? 

Nicholas Piggin (2):
  KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode
  KVM: PPC: Book3S HV: lockless tlbie for HPT hcalls

 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.16.3

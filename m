Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJD4K2d4xzDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 15:54:56 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so9310325pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 21:54:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/2] Add POWER9 DD2.0 feature, remove idle workarounds in DD2.1
Date: Fri, 20 Oct 2017 14:54:42 +1000
Message-Id: <20171020045444.4539-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin (2):
  powerpc: add POWER9_DD20 feature
  powerpc/64s: idle skip POWER9 DD1 and DD2.0 specific workarounds on
    DD2.1

 arch/powerpc/include/asm/cputable.h |  5 ++++-
 arch/powerpc/kernel/cputable.c      | 20 +++++++++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c   |  2 ++
 arch/powerpc/kernel/idle_book3s.S   | 39 ++++++++++++++++++++++++++-----------
 4 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.13.3

Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x20952NqjzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 20:09:28 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e199so29214061pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 03:09:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/3] sreset debugging improvements
Date: Tue,  4 Jul 2017 20:09:06 +1000
Message-Id: <20170704100909.8738-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are a few independent patches I've accumulated that improve
system reset handling a bit. The first 2 at least should be quite
straight forward and hopefully can be merged for 4.13.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc: do not call ppc_md.panic in panic notifier if fadump not used
  powerpc/pseries/le: work around a firmware quirk
  powerpc: do not send system reset request through the oops path

 arch/powerpc/kernel/setup-common.c   | 15 +++++++-----
 arch/powerpc/kernel/traps.c          | 47 ++++++++++++++++++++++++------------
 arch/powerpc/platforms/pseries/ras.c | 15 ++++++++++++
 3 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.11.0

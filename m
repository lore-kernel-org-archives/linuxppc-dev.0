Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmM46XNQzDqZP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:32:00 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id o126so15736021pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 23:32:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/2] prepare to treat system reset handler as NMI
Date: Mon, 20 Mar 2017 16:31:47 +1000
Message-Id: <20170320063149.3068-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This change was discussed and tested last week. This just
splits them up and adds a changelog and SOB tags for merge.

Thanks,
Nick

Nicholas Piggin (2):
  powerpc/pasemi: do not process external or decrementer interrupts from
    sreset
  powerpc/cbe: do not process external or decremeter interrupts from
    sreset

 arch/powerpc/platforms/cell/pervasive.c | 11 +++++++----
 arch/powerpc/platforms/pasemi/idle.c    | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.11.0

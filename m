Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCpCh4V7tzDsyb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 23:14:56 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i88so19280023pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 04:14:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc: oops fixes
Date: Tue,  8 Nov 2016 23:14:43 +1100
Message-Id: <20161108121445.15303-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Couple of small things I've come across. After this, injecting nmi to
enter xmon (via qemu) and then recovering works nicely.

Thanks,
Nick

Nicholas Piggin (2):
  powerpc: fix graceful debugger recovery
  powerpc: fix second nested oops hang

 arch/powerpc/kernel/traps.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.10.2

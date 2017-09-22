Return-Path: <allen.lkml@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzBH15lCCzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 21:35:09 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id i130so490619pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 04:35:09 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 0/3] use setup_timer() helper function.
Date: Fri, 22 Sep 2017 17:04:57 +0530
Message-Id: <1506080100-5660-1-git-send-email-allen.lkml@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series uses setup_timer() helper function. The series
addresses the files under arch/powerpc/*.


Allen Pais (3):
  powerpc: oprofile: use setup_timer() helper.
  powerpc: use setup_timer() helper.
  powerpc: powermac: use setup_timer() helper.

 arch/powerpc/kernel/tau_6xx.c             | 3 +--
 arch/powerpc/oprofile/op_model_cell.c     | 8 ++------
 arch/powerpc/platforms/powermac/low_i2c.c | 4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.7.4

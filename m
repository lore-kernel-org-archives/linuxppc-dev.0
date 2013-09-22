Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C1CE2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 17:42:52 +1000 (EST)
Received: by mail-pb0-f47.google.com with SMTP id rr4so1997613pbb.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 00:42:50 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 0/2] powerpc/85xx: introduce corenet_generic machine
Date: Sun, 22 Sep 2013 15:42:28 +0800
Message-Id: <1379835750-23999-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
  - Fold the original patch 2 into patch 1.
  - Update the patch 1 according to Scott and Kumar's comments.
  - Introduce a new patch to rename the corenet_ds.c to corenet_generic.c.

v1:
This patch series introduces a common machine to support p2041rdb, p3041ds,
p4080ds, p5020ds, p5040ds, t4240qds and b4qds to avoid the code duplication.
Boot test on p5020ds and p4080ds.

Kevin Hao (2):
  powerpc/85xx: introduce corenet_generic machine
  powerpc/85xx: rename the corenet_ds.c to corenet_generic.c

 arch/powerpc/platforms/85xx/Kconfig           |  10 ++
 arch/powerpc/platforms/85xx/Makefile          |   8 +-
 arch/powerpc/platforms/85xx/b4_qds.c          |  97 --------------
 arch/powerpc/platforms/85xx/corenet_ds.c      |  96 --------------
 arch/powerpc/platforms/85xx/corenet_ds.h      |  19 ---
 arch/powerpc/platforms/85xx/corenet_generic.c | 182 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/p2041_rdb.c       |  87 ------------
 arch/powerpc/platforms/85xx/p3041_ds.c        |  89 -------------
 arch/powerpc/platforms/85xx/p4080_ds.c        |  87 ------------
 arch/powerpc/platforms/85xx/p5020_ds.c        |  93 -------------
 arch/powerpc/platforms/85xx/p5040_ds.c        |  84 ------------
 arch/powerpc/platforms/85xx/t4240_qds.c       |  93 -------------
 12 files changed, 193 insertions(+), 752 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/b4_qds.c
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.h
 create mode 100644 arch/powerpc/platforms/85xx/corenet_generic.c
 delete mode 100644 arch/powerpc/platforms/85xx/p2041_rdb.c
 delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c

-- 
1.8.3.1

Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 431B32C039D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 17:17:04 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 0/2] powerpc/85xx: introduce cornet_generic machine
Date: Thu, 12 Sep 2013 15:13:11 +0800
Message-ID: <1378969993-14991-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series introduces a common machine to support p2041rdb, p3041ds,
p4080ds, p5020ds, p5040ds, t4240qds and b4qds to avoid the code duplication.
Boot test on p5020ds and p4080ds.

Kevin Hao (2):
  powerpc/85xx: introduce cornet_generic machine
  powerpc/85xx: remove the unneeded corenet_ds.h

 arch/powerpc/platforms/85xx/Kconfig      | 10 ++++
 arch/powerpc/platforms/85xx/Makefile     |  8 +--
 arch/powerpc/platforms/85xx/b4_qds.c     | 97 --------------------------------
 arch/powerpc/platforms/85xx/corenet_ds.c | 86 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/corenet_ds.h | 19 -------
 arch/powerpc/platforms/85xx/p2041_rdb.c  | 87 ----------------------------
 arch/powerpc/platforms/85xx/p3041_ds.c   | 89 -----------------------------
 arch/powerpc/platforms/85xx/p4080_ds.c   | 87 ----------------------------
 arch/powerpc/platforms/85xx/p5020_ds.c   | 93 ------------------------------
 arch/powerpc/platforms/85xx/p5040_ds.c   | 84 ---------------------------
 arch/powerpc/platforms/85xx/t4240_qds.c  | 93 ------------------------------
 11 files changed, 97 insertions(+), 656 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/b4_qds.c
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.h
 delete mode 100644 arch/powerpc/platforms/85xx/p2041_rdb.c
 delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c

-- 
1.8.3.1

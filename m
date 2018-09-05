Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424nGh4MjQzF37S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 12:10:17 +1000 (AEST)
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so2626239pff.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 19:10:17 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, joel@jms.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 0/2] Remove Variable Length Arrays from powerpc code
Date: Wed,  5 Sep 2018 12:09:49 +1000
Message-Id: <20180905020951.10372-1-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series removes two Variable Length Arrays (VLAs) from
the powerpc code.

Series based on v4.19-rc2

Suraj Jitindar Singh (2):
  powerpc/prom: Remove VLA in prom_check_platform_support()
  powerpc/pseries: Remove VLA from lparcfg_write()

 arch/powerpc/kernel/prom_init.c          | 7 +++++--
 arch/powerpc/platforms/pseries/lparcfg.c | 5 ++---
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.13.6

Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0135.outbound.protection.outlook.com [207.46.100.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D04F41A06A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:13:24 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH 0/8] clk: ppc-corenet: Add support for the platform PLL
Date: Tue, 20 Jan 2015 04:09:22 -0600
Message-ID: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches are based on:

http://patchwork.ozlabs.org/patch/417297
http://patchwork.ozlabs.org/patch/417295
http://patchwork.ozlabs.org/patch/417292

The first 5 patches below are checkpatch/static analysis fixes

Emil Medve (8):
  clk: ppc-corenet: Fix checkpatch type PARENTHESIS_ALIGNMENT
  clk: ppc-corenet: Fix checkpatch type ALLOC_WITH_MULTIPLY
  clk: ppc-corenet: Fix checkpatch type ALLOC_SIZEOF_STRUCT
  clk: ppc-corenet: Fix checkpatch type OOM_MESSAGE
  clk: ppc-corenet: Make local symbol 'static'
  clk: ppc-corenet: Replace kzalloc() with kmalloc()
  powerpc/corenet: Enable CLK_PPC_CORENET
  clk: ppc-corenet: Add support for the platform PLL

 arch/powerpc/configs/corenet32_smp_defconfig |   1 +
 arch/powerpc/configs/corenet64_smp_defconfig |   1 +
 drivers/clk/clk-ppc-corenet.c                | 120 ++++++++++++++++++++++-----
 3 files changed, 101 insertions(+), 21 deletions(-)

-- 
2.2.2

Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0144.outbound.protection.outlook.com [157.56.111.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7529F1A0DA7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 21:17:22 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH v2 00/10] clk: qoriq: Add support for the FMan clock
Date: Wed, 21 Jan 2015 04:03:22 -0600
Message-ID: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
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

Based on clk-next from git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

v2:	Rebased as several prerequisite patches (including a file rename) got
	applied upstream

Emil Medve (9):
  clk: qoriq: Fix checkpatch type PARENTHESIS_ALIGNMENT
  clk: qoriq: Fix checkpatch type ALLOC_WITH_MULTIPLY
  clk: qoriq: Fix checkpatch type ALLOC_SIZEOF_STRUCT
  clk: qoriq: Fix checkpatch type OOM_MESSAGE
  clk: qoriq: Make local symbol 'static'
  clk: qoriq: Replace kzalloc() with kmalloc()
  clk: qoriq: Use pr_fmt()
  powerpc/corenet: Enable CLK_QORIQ
  clk: qoriq: Add support for the platform PLL

Igal Liberman (1):
  clk: qoriq: Add support for the FMan clock

 arch/powerpc/configs/corenet32_smp_defconfig |   1 +
 arch/powerpc/configs/corenet64_smp_defconfig |   1 +
 drivers/clk/clk-qoriq.c                      | 378 +++++++++++++++++++++++++--
 3 files changed, 357 insertions(+), 23 deletions(-)

-- 
2.2.1

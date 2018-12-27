Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC9FC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 06:03:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552F8214AE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 06:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552F8214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43QK5r02s2zDqPH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 17:03:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43QK3X4CHwzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 17:01:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43QK3X1n1dz9s3l;
 Thu, 27 Dec 2018 17:01:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>
Subject: Re: Pull request v2: scottwood/linux.git next
In-Reply-To: <20181224022057.GA18444@home.buserror.net>
References: <20181224022057.GA18444@home.buserror.net>
Date: Thu, 27 Dec 2018 17:01:49 +1100
Message-ID: <87r2e3y0c2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Scott Wood <oss@buserror.net> writes:

> Highlights include elimination of legacy clock bindings use from dts
> files, an 83xx watchdog handler, fixes to old dts interrupt errors, and
> some minor cleanup.
>
> v2: Reverted the fsl_pci_dma_set_mask patch
>
> The following changes since commit 8c6c942d33f2a79439e86f8f406afae40a5bc767:
>
>   powerpc/eeh: Fix debugfs_simple_attr.cocci warnings (2018-12-20 22:59:03 +1100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
>
> for you to fetch changes up to 63d86876f32440a45b6f9d42ab2fb7f68b3a8bf7:
>
>   Revert "powerpc/fsl_pci: simplify fsl_pci_dma_set_mask" (2018-12-23 20:11:20 -0600)
>

Pulled, thanks.

cheers

> ----------------------------------------------------------------
> Alexandre Belloni (1):
>       powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"
>
> Christoph Hellwig (1):
>       powerpc/fsl_pci: simplify fsl_pci_dma_set_mask
>
> Christophe Leroy (1):
>       powerpc/83xx: handle machine check caused by watchdog timer
>
> Sabyasachi Gupta (1):
>       arch/powerpc/fsl_rmu: Use dma_zalloc_coherent
>
> Scott Wood (4):
>       powerpc/fsl: Use new clockgen binding
>       powerpc/dts/fsl: Fix dtc-flagged interrupt errors
>       powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL
>       Revert "powerpc/fsl_pci: simplify fsl_pci_dma_set_mask"
>
> Yuantian Tang (1):
>       clk: qoriq: add more compatibles strings
>
>  .../devicetree/bindings/clock/qoriq-clock.txt      |   6 +
>  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   4 +-
>  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   8 +-
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |  15 ---
>  arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts         | 128 ++++++++++-----------
>  arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts     | 128 ++++++++++-----------
>  arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi      |   2 +
>  arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi         |   4 +-
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  18 ---
>  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   8 +-
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  18 ---
>  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   8 +-
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |  70 -----------
>  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |  16 +--
>  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   4 +-
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  18 ---
>  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   8 +-
>  arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi     |  47 --------
>  arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi     |  30 -----
>  arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |  16 ---
>  arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |   4 +-
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  44 -------
>  arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |   8 +-
>  arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |  22 ----
>  arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi         |   8 +-
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  61 ----------
>  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  24 ++--
>  arch/powerpc/boot/dts/mpc832x_rdb.dts              |   4 -
>  arch/powerpc/configs/fsl-emb-nonhw.config          |   1 +
>  arch/powerpc/include/asm/cputable.h                |   1 +
>  arch/powerpc/include/asm/reg.h                     |   2 +
>  arch/powerpc/kernel/cputable.c                     |  10 +-
>  arch/powerpc/platforms/83xx/misc.c                 |  17 +++
>  arch/powerpc/sysdev/fsl_rio.h                      |   2 +-
>  arch/powerpc/sysdev/fsl_rmu.c                      |   4 +-
>  35 files changed, 217 insertions(+), 551 deletions(-)

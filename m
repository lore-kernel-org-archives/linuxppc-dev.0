Return-Path: <SRS0=Rflt=F2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD55C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:27:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B1A229C5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B1A229C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0cZj53CRzDqPl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Dec 2020 00:27:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0cDJ2LNczDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2020 00:11:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4D0cDH6CKJz9sWm; Wed, 23 Dec 2020 00:11:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4D0cDH2VQRz9sWc; Wed, 23 Dec 2020 00:11:27 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, masahiroy@kernel.org
In-Reply-To: <20201215032906.473460-1-mpe@ellerman.id.au>
References: <20201215032906.473460-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/boot: Fix build of dts/fsl
Message-Id: <160864266148.1929899.13857311585172845430.b4-ty@ellerman.id.au>
Date: Wed, 23 Dec 2020 00:11:27 +1100 (AEDT)
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 15 Dec 2020 14:29:06 +1100, Michael Ellerman wrote:
> The lkp robot reported that some configs fail to build, for example
> mpc85xx_smp_defconfig, with:
> 
>   cc1: fatal error: opening output file arch/powerpc/boot/dts/fsl/.mpc8540ads.dtb.dts.tmp: No such file or directory
> 
> This bisects to:
>   cc8a51ca6f05 ("kbuild: always create directories of targets")
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/boot: Fix build of dts/fsl
      https://git.kernel.org/powerpc/c/b36f835b636908e4122f2e17310b1dbc380a3b19

cheers

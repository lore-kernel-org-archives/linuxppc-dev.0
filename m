Return-Path: <SRS0=XBts=DO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EC9C4363C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 03:29:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F68208C3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 03:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F68208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C5fvp67FszDqCD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 14:29:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C5fkL14cNzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2020 14:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4C5fkK6tjTz9sVK; Wed,  7 Oct 2020 14:21:13 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200924014922.172914-1-dja@axtens.net>
References: <20200924014922.172914-1-dja@axtens.net>
Subject: Re: [PATCH] powerpc: PPC_SECURE_BOOT should not require PowerNV
Message-Id: <160204083052.257875.8942278786891498605.b4-ty@ellerman.id.au>
Date: Wed,  7 Oct 2020 14:21:13 +1100 (AEDT)
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
Cc: Nayna Jain <nayna@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 24 Sep 2020 11:49:22 +1000, Daniel Axtens wrote:
> In commit 61f879d97ce4 ("powerpc/pseries: Detect secure and trusted
> boot state of the system.") we taught the kernel how to understand the
> secure-boot parameters used by a pseries guest.
> 
> However, CONFIG_PPC_SECURE_BOOT still requires PowerNV. I didn't
> catch this because pseries_le_defconfig includes support for
> PowerNV and so everything still worked. Indeed, most configs will.
> Nonetheless, technically PPC_SECURE_BOOT doesn't require PowerNV
> any more.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: PPC_SECURE_BOOT should not require PowerNV
      https://git.kernel.org/powerpc/c/5c5e46dad939b2bf4df04293ab9ac68abd7c1f55

cheers

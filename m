Return-Path: <SRS0=fxYp=XU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF75C432C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 11:16:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E422214D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 11:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E422214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46db8w6RVLzDqdt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 21:16:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46dZwL1GPVzDqdZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 21:05:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46dZwK6vZdz9sPn; Wed, 25 Sep 2019 21:05:21 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c6fadabb2868f817299ddb338ac15885e25d12d2
In-Reply-To: <20190917004605.22471-1-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: Fix definition of PCR bits to work with old
 binutils
Message-Id: <46dZwK6vZdz9sPn@ozlabs.org>
Date: Wed, 25 Sep 2019 21:05:21 +1000 (AEST)
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
Cc: jniethe5@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Alistair Popple <alistair@popple.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-09-17 at 00:46:04 UTC, Alistair Popple wrote:
> Commit 388cc6e133132 ("KVM: PPC: Book3S HV: Support POWER6
> compatibility mode on POWER7") introduced new macros defining the PCR
> bits. When used from assembly files these definitions lead to build
> errors using older versions of binutils that don't support the 'ul'
> suffix. This fixes the build errors by updating the definitions to use
> the __MASK() macro which selects the appropriate suffix.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c6fadabb2868f817299ddb338ac15885e25d12d2

cheers

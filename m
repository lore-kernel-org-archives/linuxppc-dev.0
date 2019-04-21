Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00523C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:25:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0AE20857
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0AE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nBnV6ghWzDqNL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:25:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBds3Hv7zDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:18:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBdr4nJ8z9s5c; Mon, 22 Apr 2019 00:18:40 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBdr33jmz9s8m; Mon, 22 Apr 2019 00:18:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a273fa386a947612a23b0d56dcfb8823662b8606
X-Patchwork-Hint: ignore
In-Reply-To: <20190207051652.11380-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc/32: Add ppc_defconfig
Message-Id: <44nBdr33jmz9s8m@ozlabs.org>
Date: Mon, 22 Apr 2019 00:18:40 +1000 (AEST)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-02-07 at 05:16:51 UTC, Michael Ellerman wrote:
> Add a generic 32-bit defconfig called ppc_defconfig. This means we'll
> have a defconfig matching "uname -m" for all cases.
> 
> This config is mostly intended for build testing but if someone wants
> to tweak it to get it booting on something that would be fine too.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Tested-by: Mathieu Malaterre <malat@debian.org>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/a273fa386a947612a23b0d56dcfb8823

cheers

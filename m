Return-Path: <SRS0=8MEZ=VA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824A1C0650E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 14:36:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8CE21850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 14:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8CE21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45f3ZT2z2jzDqPF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 00:36:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45f3Mp1n3PzDq9J
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2019 00:27:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45f3Mp0LgZz9s4Y; Thu,  4 Jul 2019 00:27:01 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ba45cff610a4223ce3ad98a700a820e3d60e3f7c
In-Reply-To: <20190513053910.19227-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Document xive=off option
Message-Id: <45f3Mp0LgZz9s4Y@ozlabs.org>
Date: Thu,  4 Jul 2019 00:27:01 +1000 (AEST)
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 =?utf-8?b?Q8OpZHJp?= =?utf-8?q?c_Le_Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-05-13 at 05:39:10 UTC, Michael Neuling wrote:
> commit 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE
> interrupt controller") added an option to turn off Linux native XIVE
> usage via the xive=off kernel command line option.
> 
> This documents this option.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Acked-by: Stewart Smith <stewart@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ba45cff610a4223ce3ad98a700a820e3d60e3f7c

cheers

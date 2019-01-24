Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04774C282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 04:12:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA2F2184B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 04:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA2F2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lTJW5L2DzDqBN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 15:12:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lSbl526PzDqGP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 14:40:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43lSbl0vNKz9sNR; Thu, 24 Jan 2019 14:40:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 63da6caeb84cfad3d1e5774b7049dd1d2c9dec62
X-Patchwork-Hint: ignore
In-Reply-To: <20180907153526.19616-1-igor.stoppa@huawei.com>
To: Igor Stoppa <igor.stoppa@gmail.com>, Arseny Solokha <asolokha@kb.kras.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: remove unnecessary unlikely()
Message-Id: <43lSbl0vNKz9sNR@ozlabs.org>
Date: Thu, 24 Jan 2019 14:40:34 +1100 (AEDT)
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
Cc: igor.stoppa@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Igor Stoppa <igor.stoppa@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-09-07 at 15:35:26 UTC, Igor Stoppa wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to
> wrap it into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Arseny Solokha <asolokha@kb.kras.ru>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/63da6caeb84cfad3d1e5774b7049dd1d

cheers

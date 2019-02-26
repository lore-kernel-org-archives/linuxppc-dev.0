Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258C5C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 03:35:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC35D206B8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 03:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC35D206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447kx74sqWzDq9H
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 14:35:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447klq4Y20zDqM2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 14:27:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 447klq3Nv0z9sDL; Tue, 26 Feb 2019 14:27:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6d183ca8baec983dc4208ca45ece3c36763df912
X-Patchwork-Hint: ignore
In-Reply-To: <e3ad0e890941de019189a616cbb40c3665264b37.1550775950.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v5,
 01/16] powerpc/wii: properly disable use of BATs when requested.
Message-Id: <447klq3Nv0z9sDL@ozlabs.org>
Date: Tue, 26 Feb 2019 14:27:51 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-02-21 at 19:08:37 UTC, Christophe Leroy wrote:
> 'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
> deny the use of BATS for mapping memory.
> 
> This patch makes sure that the specific wii RAM mapping function
> takes it into account as well.
> 
> Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6d183ca8baec983dc4208ca45ece3c36

cheers

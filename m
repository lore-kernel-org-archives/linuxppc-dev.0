Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B54C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:53:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8392087B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8392087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nCQT4F8tzDq9Z
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:53:53 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBfJ74dBzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:19:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBfJ3wrsz9sMx; Mon, 22 Apr 2019 00:19:04 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e663e1e06089773cdab03023563aead65cfed042
X-Patchwork-Hint: ignore
In-Reply-To: <20190407015447.39292-1-cai@lca.pw>
To: Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries/pmem: fix a set but not used value
Message-Id: <44nBfJ3wrsz9sMx@ozlabs.org>
Date: Mon, 22 Apr 2019 00:19:04 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, oohall@gmail.com, Qian Cai <cai@lca.pw>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2019-04-07 at 01:54:47 UTC, Qian Cai wrote:
> The commit 4c5d87db4978 ("powerpc/pseries: PAPR persistent memory
> support") set a local variable "count" in dlpar_hp_pmem() but never
> use it.
> 
> arch/powerpc/platforms/pseries/pmem.c: In function 'dlpar_hp_pmem':
> arch/powerpc/platforms/pseries/pmem.c:109:6: warning: variable 'count'
> set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e663e1e06089773cdab03023563aead6

cheers

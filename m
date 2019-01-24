Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A93FC282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 04:08:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81652084C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 04:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81652084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lTDK3kk1zDqHV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 15:08:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lSbh6yVDzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 14:40:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43lSbh2g7Mz9sN6; Thu, 24 Jan 2019 14:40:31 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 797eadd9c80ca3b3f913ccde29f8a6015f9974f9
X-Patchwork-Hint: ignore
In-Reply-To: <20190114004138.130559-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [kernel] powerpc/powernv/npu: Remove obsolete comment about
 TCE_KILL_INVAL_ALL
Message-Id: <43lSbh2g7Mz9sN6@ozlabs.org>
Date: Thu, 24 Jan 2019 14:40:31 +1100 (AEDT)
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-01-14 at 00:41:38 UTC, Alexey Kardashevskiy wrote:
> TCE_KILL_INVAL_ALL has moved long ago but the comment was forgotted so
> finish the move and remove the comment.
> 
> Fixes: 0bbcdb437da0c4a "powerpc/powernv/npu: TCE Kill helpers cleanup"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/797eadd9c80ca3b3f913ccde29f8a601

cheers

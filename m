Return-Path: <SRS0=y999=XO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05286C3A5A6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 10:42:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA8921927
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 10:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA8921927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Ythf5hftzF4s7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 20:42:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46YtKR5y4HzF4XX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2019 20:25:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46YtKQ5srVz9sPT; Thu, 19 Sep 2019 20:25:45 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b4d37a7b6934c0c16930c73f43c08e9a6af22f1a
In-Reply-To: <20190903165147.11099-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, paulus@samba.org, benh@kernel.crashing.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: remove the unused
 pnv_npu_try_dma_set_bypass function
Message-Id: <46YtKQ5srVz9sPT@ozlabs.org>
Date: Thu, 19 Sep 2019 20:25:45 +1000 (AEST)
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

On Tue, 2019-09-03 at 16:51:47 UTC, Christoph Hellwig wrote:
> Neither pnv_npu_try_dma_set_bypass nor the pnv_npu_dma_set_32 and
> pnv_npu_dma_set_bypass helpers called by it are used anywhere in the
> kernel tree, so remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b4d37a7b6934c0c16930c73f43c08e9a6af22f1a

cheers

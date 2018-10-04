Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE4DC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:43:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763FC213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763FC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QjyR2nmtzF3FM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:43:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjKF4sNWzF3BM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:14:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42QjKF2wcZzB4MQ; Thu,  4 Oct 2018 16:14:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cd5ff94577e004e0a4457e70d0ef3a030f4010b8
In-Reply-To: <1537963772-15309-1-git-send-email-zhongjiang@huawei.com>
To: zhong jiang <zhongjiang@huawei.com>, <paulus@samba.org>,
 <akpm@linux-foundation.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: xive: Move a dereference below a NULL test
Message-Id: <42QjKF2wcZzB4MQ@ozlabs.org>
Date: Thu,  4 Oct 2018 16:14:40 +1000 (AEST)
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
Cc: fthain@telegraphics.com.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, fbarrat@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-09-26 at 12:09:32 UTC, zhong jiang wrote:
> It is safe to move dereference below a NULL test.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cd5ff94577e004e0a4457e70d0ef3a

cheers

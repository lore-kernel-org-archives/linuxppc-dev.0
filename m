Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A7C0650E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 01:38:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9144420673
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 01:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9144420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45hp4w3qmWzDqLN
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 11:38:40 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45hnfv1RGbzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2019 11:19:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45hnft2p3Fz9sP7; Mon,  8 Jul 2019 11:19:33 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 41732bdc9ccd26829cf647711c4b93384e03e529
In-Reply-To: <20190528032925.8836-1-stewart@linux.ibm.com>
To: Stewart Smith <stewart@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [TRIVIAL] [PATCH] powerpc/powernv-eeh: Consisely desribe what
 this file does
Message-Id: <45hnft2p3Fz9sP7@ozlabs.org>
Date: Mon,  8 Jul 2019 11:19:33 +1000 (AEST)
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
Cc: sbobroff@linux.ibm.com, paulus@samba.org, oohall@gmail.com,
 Stewart Smith <stewart@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-05-28 at 03:29:25 UTC, Stewart Smith wrote:
> If the previous comment made sense, continue debugging or call your
> doctor immediately.
> 
> Signed-off-by: Stewart Smith <stewart@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/41732bdc9ccd26829cf647711c4b93384e03e529

cheers

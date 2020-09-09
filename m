Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83538C43461
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 14:12:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835BE221F0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 14:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835BE221F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BmkVD0RtmzDqBj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 00:12:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjW55t5dzDqJK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:27:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjW42ppJz9sVp; Wed,  9 Sep 2020 23:27:44 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Joel Stanley <joel@jms.id.au>
In-Reply-To: <20190801051630.5804-1-joel@jms.id.au>
References: <20190801051630.5804-1-joel@jms.id.au>
Subject: Re: [PATCH] powerpc/powernv: Print helpful message when cores guarded
Message-Id: <159965717546.808686.15037924614496765388.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:27:44 +1000 (AEST)
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

On Thu, 1 Aug 2019 14:46:30 +0930, Joel Stanley wrote:
> Often the firmware will guard out cores after a crash. This often
> undesirable, and is not immediately noticeable.
> 
> This adds an informative message when a CPU device tree nodes are marked
> bad in the device tree.

Applied to powerpc/next.

[1/1] powerpc/powernv: Print helpful message when cores guarded
      https://git.kernel.org/powerpc/c/8f55984f530d7275531e17f36ea29229c2c410dd

cheers

Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B47C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:48:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13F164E6F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13F164E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbLgl1V8GzDsTw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 00:48:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKY95VTwzDrgn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:33 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKY825rlz9sVt; Wed, 10 Feb 2021 23:57:32 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Chengyang Fan <cy.fan@huawei.com>, mpe@ellerman.id.au
In-Reply-To: <20210125095338.1719405-1-cy.fan@huawei.com>
References: <20210125095338.1719405-1-cy.fan@huawei.com>
Subject: Re: [PATCH] powerpc: remove unneeded semicolons
Message-Id: <161296171966.3178259.9297308863330851895.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:32 +1100 (AEDT)
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
Cc: joe@perches.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 25 Jan 2021 17:53:38 +0800, Chengyang Fan wrote:
> Remove superfluous semicolons after function definitions.

Applied to powerpc/next.

[1/1] powerpc: remove unneeded semicolons
      https://git.kernel.org/powerpc/c/6c6fdbb2b7002aa04e418b5d2b26df1c5ba5ab80

cheers

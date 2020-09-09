Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED50C10DAA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:02:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BEA22268
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BEA22268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bmlbp3TFQzDqXV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 01:01:58 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjWP4HgPzDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:28:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjWP01gtz9sW4; Wed,  9 Sep 2020 23:28:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>
In-Reply-To: <20200828020542.393022-1-ruscur@russell.cc>
References: <20200828020542.393022-1-ruscur@russell.cc>
Subject: Re: [PATCH] powerpc/tools: Remove 90 line limit in checkpatch script
Message-Id: <159965717409.808686.14538029470863523106.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:28:00 +1000 (AEST)
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

On Fri, 28 Aug 2020 12:05:42 +1000, Russell Currey wrote:
> As of commit bdc48fa11e46, scripts/checkpatch.pl now has a default line
> length warning of 100 characters.  The powerpc wrapper script was using
> a length of 90 instead of 80 in order to make checkpatch less
> restrictive, but now it's making it more restrictive instead.
> 
> I think it makes sense to just use the default value now.

Applied to powerpc/next.

[1/1] powerpc/tools: Remove 90 line limit in checkpatch script
      https://git.kernel.org/powerpc/c/0fb4871bcc8997acbb8edf14b301fc150101d6c0

cheers

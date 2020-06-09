Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBB3C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:34:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4651420760
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4651420760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h0hm1K2szDr49
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:34:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzFn3n1fzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:29:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49gzFT17gDz9sV7; Tue,  9 Jun 2020 15:29:17 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzFS129vz9sSy; Tue,  9 Jun 2020 15:29:15 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200520111740.953679-1-mpe@ellerman.id.au>
References: <20200520111740.953679-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/xmon: Show task->thread.regs in process display
Message-Id: <159168034411.1381411.2398287367773987604.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:29:15 +1000 (AEST)
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

On Wed, 20 May 2020 21:17:40 +1000, Michael Ellerman wrote:
> Show the address of the tasks regs in the process listing in xmon. The
> regs should always be on the stack page that we also print the address
> of, but it's still helpful not to have to find them by hand.

Applied to powerpc/next.

[1/1] powerpc/xmon: Show task->thread.regs in process display
      https://git.kernel.org/powerpc/c/0e7e92efe11bc5993def689e10f7bcb36f127651

cheers

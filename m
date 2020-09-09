Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A7C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:08:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B56C22268
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B56C22268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bmllf1T7XzDqF3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 01:08:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjWQ5544zDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:28:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjWQ1ZyFz9sW5; Wed,  9 Sep 2020 23:28:01 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200811140435.20957-1-sfr@canb.auug.org.au>
References: <20200811140435.20957-1-sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/7] powerpc: unrel_branch_check.sh: make it suck less
Message-Id: <159965716980.808686.15231955060688132897.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:28:01 +1000 (AEST)
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
Cc: Linux PowerPC List <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 12 Aug 2020 00:04:27 +1000, Stephen Rothwell wrote:
> Michael Ellerman: "who wants to make
> arch/powerpc/tools/unrel_branch_check.sh suck less"
> 
> This series is based off the current powerpc/next branch and keeps the
> same functionaity as the original except that it suppresses some error
> messages for early failures that still cause this script to succeed
> (as it always did).
> 
> [...]

Applied to powerpc/next.

[1/7] powerpc: unrel_branch_check.sh: fix shellcheck complaints
      https://git.kernel.org/powerpc/c/d9de6b0da85c9f51734f7648f6e860b89f94c801
[2/7] powerpc: unrel_branch_check.sh: simplify and combine some executions
      https://git.kernel.org/powerpc/c/20ff8ec182160df86571a8af5773ff1e52837d73
[3/7] powerpc: unrel_branch_check.sh: simplify objdump's asm output
      https://git.kernel.org/powerpc/c/4e71106c343c625c0bf72a65b244e35e7d2cd037
[4/7] powerpc: unrel_branch_check.sh: convert grep | sed | awk to just sed
      https://git.kernel.org/powerpc/c/3d97abbc9f6fe90973551f3e3eef47ffef863114
[5/7] powerpc: unrel_branch_check.sh: simplify and tidy up the final loop
      https://git.kernel.org/powerpc/c/b84eaab6ede6477484edc043456cf7d7cfc7f8b3
[6/7] powerpc: unrel_branch_check.sh: fix up the file header
      https://git.kernel.org/powerpc/c/3745ae63b405b09c86718f95d96c4b2d2827b087
[7/7] powerpc: unrel_branch_check.sh: exit silently for early errors
      https://git.kernel.org/powerpc/c/af13a2244d59c4d63a25abd8257cbaef9d9ffebc

cheers

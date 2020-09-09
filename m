Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7084C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:12:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0574521919
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0574521919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bmlr05D05zDqYW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 01:12:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjWQ558SzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:28:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjWP4FNKz9sVg; Wed,  9 Sep 2020 23:28:01 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200812081036.7969-1-sfr@canb.auug.org.au>
References: <20200812081036.7969-1-sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/2] powerpc: unrel_branch_check.sh: enable llvm-objdump
Message-Id: <159965717016.808686.13970722427818148580.b4-ty@ellerman.id.au>
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
 Bill Wendling <morbo@google.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 12 Aug 2020 18:10:34 +1000, Stephen Rothwell wrote:
> These 2 patches enable this script to work properly when llvm-objtool
> is being used.
> 
> They depend on my previos series that make this script suck less.

Applied to powerpc/next.

[1/2] powerpc: unrel_branch_check.sh: use nm to find symbol value
      https://git.kernel.org/powerpc/c/b71dca9891b330d5c2d3ff5d41704aa6f64f8e32
[2/2] powerpc: unrel_branch_check.sh: enable the use of llvm-objdump v9, 10 or 11
      https://git.kernel.org/powerpc/c/6b1992bcdee8b86a74362192d4d8906731918bcc

cheers

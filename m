Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E5DC433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 14:31:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BE2206F4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 14:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BE2206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BmkwP2t0KzDqFv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 00:31:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjWH5DCmzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:27:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BmjWH23rCz9sW0; Wed,  9 Sep 2020 23:27:55 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjWG4pR4z9sVT; Wed,  9 Sep 2020 23:27:54 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200813013445.686464-1-mpe@ellerman.id.au>
References: <20200813013445.686464-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] selftests/powerpc: Fix TM tests when CPU 0 is offline
Message-Id: <159965717160.808686.14918633881818256625.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:27:54 +1000 (AEST)
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

On Thu, 13 Aug 2020 11:34:43 +1000, Michael Ellerman wrote:
> Several of the TM tests fail spuriously if CPU 0 is offline, because
> they blindly try to affinitise to CPU 0.
> 
> Fix them by picking any online CPU and using that instead.

Applied to powerpc/next.

[1/3] selftests/powerpc: Fix TM tests when CPU 0 is offline
      https://git.kernel.org/powerpc/c/c0176429b7b07893a5c1fd38baff055c919ba9e3
[2/3] selftests/powerpc: Don't use setaffinity in tm-tmspr
      https://git.kernel.org/powerpc/c/769628710c33b18ede837bb488e1d24084b35592
[3/3] selftests/powerpc: Run tm-tmspr test for longer
      https://git.kernel.org/powerpc/c/b5a646a681f5d67ea5190a71d6e84a91efe63b7a

cheers

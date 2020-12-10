Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07043C433FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 13:43:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0008C23119
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 13:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0008C23119
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsFW55D1ZzDqQL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 00:43:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsBXx4VfSzDqjN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 22:30:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CsBXx1b7cz9sXg; Thu, 10 Dec 2020 22:30:08 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Harish <harish@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <20201201092403.238182-1-harish@linux.ibm.com>
References: <20201201092403.238182-1-harish@linux.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Fix uninitialized variable warning
Message-Id: <160756606071.1313423.14413619656072844015.b4-ty@ellerman.id.au>
Date: Thu, 10 Dec 2020 22:30:08 +1100 (AEDT)
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

On Tue, 1 Dec 2020 14:54:03 +0530, Harish wrote:
> Patch fixes uninitialized variable warning in bad_accesses test
> which causes the selftests build to fail in older distibutions
> 
> bad_accesses.c: In function ‘bad_access’:
> bad_accesses.c:52:9: error: ‘x’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    printf("Bad - no SEGV! (%c)\n", x);
>          ^
> cc1: all warnings being treated as errors

Applied to powerpc/next.

[1/1] selftests/powerpc: Fix uninitialized variable warning
      https://git.kernel.org/powerpc/c/c9344769e2b46ba28b947bec7a8a8f0a091ecd57

cheers

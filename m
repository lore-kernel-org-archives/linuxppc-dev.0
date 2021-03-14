Return-Path: <SRS0=qxeE=IM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16F9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 10:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5F164ECD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 10:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5F164ECD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DywBb74THz3f7Y
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 21:04:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dyw7B1r43z3cX0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 21:01:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Dyw761HXlz9sWS; Sun, 14 Mar 2021 21:01:22 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, llvmlinux@lists.linuxfoundation.org,
 Daniel Axtens <dja@axtens.net>
In-Reply-To: <20210225031006.1204774-1-dja@axtens.net>
References: <20210225031006.1204774-1-dja@axtens.net>
Subject: Re: [RFC PATCH 0/8] WIP support for the LLVM integrated assembler
Message-Id: <161571587307.138988.1094376182058512034.b4-ty@ellerman.id.au>
Date: Sun, 14 Mar 2021 21:01:22 +1100 (AEDT)
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

On Thu, 25 Feb 2021 14:09:58 +1100, Daniel Axtens wrote:
> To support Clang's CFI we need LTO. For LTO, we need to be able to compile
> with the LLVM integrated assembler.
> 
> Currently, we can't.
> 
> This series gets us a bit closer, but I'm still stuck and I'm hoping
> someone can point me in the right direction.
> 
> [...]

Patch 1 applied to powerpc/fixes.

[1/8] powerpc/64s/exception: Clean up a missed SRR specifier
      https://git.kernel.org/powerpc/c/c080a173301ffc62cb6c76308c803c7fee05517a

cheers

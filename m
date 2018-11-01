Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9DAC0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 12:54:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6008120657
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 12:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6008120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m4s417bZzF3N5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 23:54:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m4hs4sPYzF3Ln
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 23:46:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42m4hs2gF6zB4X6; Thu,  1 Nov 2018 23:46:53 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42m4hs0PFKzB4XS; Thu,  1 Nov 2018 23:46:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c39b79082a38a4f8c801790edecbbb4d62ed2992
In-Reply-To: <20181029112353.15805-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/5] selftests/powerpc/ptrace: Fix out-of-tree build
Message-Id: <42m4hs0PFKzB4XS@ozlabs.org>
Date: Thu,  1 Nov 2018 23:46:52 +1100 (AEDT)
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
Cc: joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-10-29 at 11:23:49 UTC, Michael Ellerman wrote:
> From: Joel Stanley <joel@jms.id.au>
> 
> We should use TEST_GEN_PROGS, not TEST_PROGS. That tells the selftests
> makefile (lib.mk) that those tests are generated (built), and so it
> adds the $(OUTPUT) prefix for us, making the out-of-tree build work
> correctly.
> 
> It also means we don't need our own clean rule, lib.mk does it.
> 
> We also have to update the ptrace-pkey and core-pkey rules to use
> $(OUTPUT).
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/c39b79082a38a4f8c801790edecbbb

cheers

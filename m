Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1C5CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 12:37:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B75A2080F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 12:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B75A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4737Jl0yNYzF3wP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 23:37:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4736np37SQzF4Bc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 23:14:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4736nn5D3Sz9sPd; Wed, 30 Oct 2019 23:14:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4736nn1GkHz9sR5; Wed, 30 Oct 2019 23:14:20 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cd1d55f16d48d97d681d9534170ce712ac1d09e7
In-Reply-To: <157063484064.11906.3586824898111397624.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc: make syntax for FADump config options in
 kernel/Makefile readable
Message-Id: <4736nn1GkHz9sR5@ozlabs.org>
Date: Wed, 30 Oct 2019 23:14:20 +1100 (AEDT)
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
Cc: joel@jms.id.au, Vasant Hegde <hegdevasant@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-10-09 at 15:27:20 UTC, Hari Bathini wrote:
> arch/powerpc/kernel/fadump.c file needs to be compiled in if 'config
> FA_DUMP' or 'config PRESERVE_FA_DUMP' is set. The current syntax
> achieves that but looks a bit odd. Fix it for better readability.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cd1d55f16d48d97d681d9534170ce712ac1d09e7

cheers

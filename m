Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55818C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:30:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BE464F95
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BE464F95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW1Hh4KFnzF32M
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 23:30:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09b0Mg0zDwtB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09Y2cnFz9vDk; Wed,  3 Feb 2021 22:40:32 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Pingfan Liu <kernelfans@gmail.com>
In-Reply-To: <1603349479-26185-1-git-send-email-kernelfans@gmail.com>
References: <1603349479-26185-1-git-send-email-kernelfans@gmail.com>
Subject: Re: [PATCH] powerpc/time: enable sched clock for irqtime
Message-Id: <161235200779.1516112.16498993664368621060.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:32 +1100 (AEDT)
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 22 Oct 2020 14:51:19 +0800, Pingfan Liu wrote:
> When CONFIG_IRQ_TIME_ACCOUNTING and CONFIG_VIRT_CPU_ACCOUNTING_GEN, powerpc
> does not enable "sched_clock_irqtime" and can not utilize irq time
> accounting.
> 
> Like x86, powerpc does not use the sched_clock_register() interface. So it
> needs an dedicated call to enable_sched_clock_irqtime() to enable irq time
> accounting.

Applied to powerpc/next.

[1/1] powerpc/time: Enable sched clock for irqtime
      https://git.kernel.org/powerpc/c/b709e32ef570b8b91dfbcb63cffac4324c87799f

cheers

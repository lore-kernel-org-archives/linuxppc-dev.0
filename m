Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF73C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:15:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851E961106
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851E961106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNtky1nlNz3h4v
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:15:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtWD3XBgz3cPd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:56 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtW36lkFz9vGg; Mon, 19 Apr 2021 14:04:43 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Yu Kuai <yukuai3@huawei.com>, benh@kernel.crashing.org
In-Reply-To: <20210407125738.4138480-1-yukuai3@huawei.com>
References: <20210407125738.4138480-1-yukuai3@huawei.com>
Subject: Re: [PATCH] windfarm: make symbol 'wf_thread' static
Message-Id: <161880479082.1398509.3847359134460061965.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 13:59:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, zhangxiaoxu5@huawei.com,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 7 Apr 2021 20:57:38 +0800, Yu Kuai wrote:
> The sparse tool complains as follows:
> 
> drivers/macintosh/windfarm_core.c:59:20: warning:
>  symbol 'wf_thread' was not declared. Should it be static?
> 
> This symbol is not used outside of windfarm_core.c, so this
> commit marks it static.

Applied to powerpc/next.

[1/1] windfarm: make symbol 'wf_thread' static
      https://git.kernel.org/powerpc/c/4204ecd598cb0a044e6fcfd48e569080955347f4

cheers

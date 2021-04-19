Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4BEC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:10:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D0A61106
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D0A61106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNtdf6P87z3fqY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:10:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtVq1xvlz3cVw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:35 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVl0sGnz9vH5; Mon, 19 Apr 2021 14:04:30 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, christophe.leroy@c-s.fr,
 joel@jms.id.au, paulus@samba.org, Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20210408062012.85973-1-pulehui@huawei.com>
References: <20210408062012.85973-1-pulehui@huawei.com>
Subject: Re: [PATCH -next] powerpc/fadump: make symbol
 'rtas_fadump_set_regval' static
Message-Id: <161880480163.1398509.9529896301333711688.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 14:00:01 +1000
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
Cc: zhangjinhao2@huawei.com, yangjihong1@huawei.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 8 Apr 2021 14:20:12 +0800, Pu Lehui wrote:
> Fix sparse warnings:
> 
> arch/powerpc/platforms/pseries/rtas-fadump.c:250:6: warning:
>  symbol 'rtas_fadump_set_regval' was not declared. Should it be static?

Applied to powerpc/next.

[1/1] powerpc/fadump: make symbol 'rtas_fadump_set_regval' static
      https://git.kernel.org/powerpc/c/59fd366b9bef2d048af763e27cd1622ee5a1dfd4

cheers

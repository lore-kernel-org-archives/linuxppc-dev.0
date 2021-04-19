Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB4DC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:08:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A67E610A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A67E610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNtbJ0jV6z3cNH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:08:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtVY6nP5z3cKn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:21 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVW5p1zz9vDw; Mon, 19 Apr 2021 14:04:19 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, mahesh@linux.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, santosh@fossix.org, christophe.leroy@csgroup.eu,
 paulus@samba.org, Li Huafei <lihuafei1@huawei.com>, ganeshgr@linux.ibm.com,
 clg@kaod.org
In-Reply-To: <20210408035802.31853-1-lihuafei1@huawei.com>
References: <20210408035802.31853-1-lihuafei1@huawei.com>
Subject: Re: [PATCH -next] powerpc/mce: Make symbol 'mce_ue_event_work' static
Message-Id: <161880479027.1398509.16254201379710862051.b4-ty@ellerman.id.au>
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
Cc: zhangjinhao2@huawei.com, yangjihong1@huawei.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 8 Apr 2021 11:58:02 +0800, Li Huafei wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/kernel/mce.c:43:1: warning:
>  symbol 'mce_ue_event_work' was not declared. Should it be static?
> 
> This symbol is not used outside of mce.c, so this commit marks it
> static.

Applied to powerpc/next.

[1/1] powerpc/mce: Make symbol 'mce_ue_event_work' static
      https://git.kernel.org/powerpc/c/f6f1f48e8b3b242dfa684d6e1b930d239d87533a

cheers

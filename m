Return-Path: <SRS0=fR6Q=BJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FAC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:12:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148752074B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148752074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHW6q5771zDqn1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 23:12:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHVct6lYqzDqws
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 22:50:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BHVct0pG6z9sSt; Thu, 30 Jul 2020 22:50:21 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>, Qinglang Miao <miaoqinglang@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20200728022807.87815-1-miaoqinglang@huawei.com>
References: <20200728022807.87815-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] powerpc: use for_each_child_of_node() macro
Message-Id: <159611328022.1601380.18437120131369236734.b4-ty@ellerman.id.au>
Date: Thu, 30 Jul 2020 22:50:21 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 28 Jul 2020 10:28:07 +0800, Qinglang Miao wrote:
> Use for_each_child_of_node() macro instead of open coding it.

Applied to powerpc/next.

[1/1] powerpc: use for_each_child_of_node() macro
      https://git.kernel.org/powerpc/c/b6ac59d39a348af29477d7bfdc3ba23526e3f4ea

cheers

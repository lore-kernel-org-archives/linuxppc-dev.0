Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B9FC3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 04:27:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6C02080F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 04:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6C02080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JCPX30zzzDqyZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 14:26:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JCM33JTDzDqsr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 14:24:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46JCM32Km6z9sN6; Wed, 28 Aug 2019 14:24:47 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7e04a46d84f73ef0f21d2257d6ba2a194c0f1511
In-Reply-To: <20190627053008.29315-1-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/configs: Disable /dev/port in skiroot defconfig
Message-Id: <46JCM32Km6z9sN6@ozlabs.org>
Date: Wed, 28 Aug 2019 14:24:47 +1000 (AEST)
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-06-27 at 05:30:08 UTC, Daniel Axtens wrote:
> While reviewing lockdown patches, I discovered that we still enable
> /dev/port (CONFIG_DEVPORT) in skiroot.
> 
> We don't need it. Deselect CONFIG_DEVPORT for skiroot.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7e04a46d84f73ef0f21d2257d6ba2a194c0f1511

cheers

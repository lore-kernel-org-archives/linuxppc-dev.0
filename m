Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F9CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 12:17:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E7D2083E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 12:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E7D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4736s82NVSzF3Xr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 23:17:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4736nf0kxhzF4BM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 23:14:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4736nd6yvvz9sPd; Wed, 30 Oct 2019 23:14:13 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4736nd60Fzz9sPj; Wed, 30 Oct 2019 23:14:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 58b12eb28e34d3dd8a2d6743c26bf941ca1fbf37
In-Reply-To: <20190528081614.26096-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/configs: Rename foo_basic_defconfig to
 foo_base.config
Message-Id: <4736nd60Fzz9sPj@ozlabs.org>
Date: Wed, 30 Oct 2019 23:14:13 +1100 (AEDT)
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

On Tue, 2019-05-28 at 08:16:14 UTC, Michael Ellerman wrote:
> We have several "defconfigs" that are not actually full defconfigs
> they are just a base set of options which are then merged with other
> fragments to produce a working defconfig.
> 
> The most obvious example is corenet_basic_defconfig which only
> contains one symbol CONFIG_CORENET_GENERIC=y. But there is also
> mpc85xx_base_defconfig which doesn't actually enable CONFIG_PPC_85xx.
> 
> To avoid confusion, rename these config fragments to "foo_base.config"
> to make it clearer that they are not full defconfigs.
> 
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/58b12eb28e34d3dd8a2d6743c26bf941ca1fbf37

cheers

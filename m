Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0AC433C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:11:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88324619CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88324619CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97Z61xnhz3dCy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:11:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97XK3d8Xz3bsB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:09 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97XK1yZ5z9sWk; Wed, 31 Mar 2021 12:10:09 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 rashmicy@gmail.com, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <9881c68fbca004f9ea18fc9473f630e11ccd6417.1615806071.git.christophe.leroy@csgroup.eu>
References: <9881c68fbca004f9ea18fc9473f630e11ccd6417.1615806071.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/asm-offsets: GPR14 is not needed either
Message-Id: <161715297765.226945.4352182922403291412.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:37 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Mar 2021 11:01:26 +0000 (UTC), Christophe Leroy wrote:
> Commit aac6a91fea93 ("powerpc/asm: Remove unused symbols in
> asm-offsets.c") removed GPR15 to GPR31 but kept GPR14,
> probably because it pops up in a couple of comments when doing
> a grep.
> 
> However, it was never used either, so remove it as well.

Applied to powerpc/next.

[1/1] powerpc/asm-offsets: GPR14 is not needed either
      https://git.kernel.org/powerpc/c/6eeca7a11379e9dd05493bbdba57515b36a2e3cf

cheers

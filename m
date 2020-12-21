Return-Path: <SRS0=4INi=FZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D8CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 11:46:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34CC22BEA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 11:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34CC22BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CzyNH3jDmzDq8g
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 22:46:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CzxRC3Ly2zDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2020 22:03:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CzxRB3J50z9sW0; Mon, 21 Dec 2020 22:03:34 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: "xiakaixu1987@gmail.com" <xiakaixu1987@gmail.com>, paulus@ozlabs.org
In-Reply-To: <1604764178-8087-1-git-send-email-kaixuxia@tencent.com>
References: <1604764178-8087-1-git-send-email-kaixuxia@tencent.com>
Subject: Re: [PATCH] KVM: PPC: fix comparison to bool warning
Message-Id: <160854857735.1696279.7271501968422193130.b4-ty@ellerman.id.au>
Date: Mon, 21 Dec 2020 22:03:34 +1100 (AEDT)
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
Cc: Kaixu Xia <kaixuxia@tencent.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 7 Nov 2020 23:49:38 +0800, xiakaixu1987@gmail.com wrote:
> Fix the following coccicheck warning:
> 
> ./arch/powerpc/kvm/booke.c:503:6-16: WARNING: Comparison to bool
> ./arch/powerpc/kvm/booke.c:505:6-17: WARNING: Comparison to bool
> ./arch/powerpc/kvm/booke.c:507:6-16: WARNING: Comparison to bool

Applied to powerpc/next.

[1/1] KVM: PPC: fix comparison to bool warning
      https://git.kernel.org/powerpc/c/a300bf8c5f24bdeaa84925d1e0ec6221cbdc7597

cheers

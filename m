Return-Path: <SRS0=zlGz=J2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EF4C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:04:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4445261400
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4445261400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWHLx39Fcz3brS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 00:04:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWHJ61MRLz30FK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 00:02:30 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FWHJ36Hwsz9t1r; Fri, 30 Apr 2021 00:02:27 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Colin King <colin.king@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <20201216113608.11812-1-colin.king@canonical.com>
References: <20201216113608.11812-1-colin.king@canonical.com>
Subject: Re: [PATCH] powerpc/44x: fix spelling mistake in Kconfig "varients"
 -> "variants"
Message-Id: <161970488570.4033873.12486603627255933756.b4-ty@ellerman.id.au>
Date: Fri, 30 Apr 2021 00:01:25 +1000
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 16 Dec 2020 11:36:08 +0000, Colin King wrote:
> There is a spelling mistake in the Kconfig help text. Fix it.

Applied to powerpc/next.

[1/1] powerpc/44x: fix spelling mistake in Kconfig "varients" -> "variants"
      https://git.kernel.org/powerpc/c/ee6b25fa7c037e42cc5f3b5c024b2a779edab6dd

cheers

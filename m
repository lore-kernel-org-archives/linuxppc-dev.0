Return-Path: <SRS0=S0KY=CI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E08FC433E6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2020 11:41:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389F7207DA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2020 11:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389F7207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BfWdG5qc9zDqZC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2020 21:41:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BfWb90Y7qzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2020 21:39:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BfWb84lKlz9sTF; Sun, 30 Aug 2020 21:39:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, giuseppe@sguazz.it,
 Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <ec96c15bfa1a7415ab604ee1c98cd45779c08be0.1598553015.git.christophe.leroy@csgroup.eu>
References: <ec96c15bfa1a7415ab604ee1c98cd45779c08be0.1598553015.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32s: Disable VMAP stack which CONFIG_ADB_PMU
Message-Id: <159878757051.255624.17808533477852714140.b4-ty@ellerman.id.au>
Date: Sun, 30 Aug 2020 21:39:48 +1000 (AEST)
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

On Thu, 27 Aug 2020 18:30:27 +0000 (UTC), Christophe Leroy wrote:
> low_sleep_handler() can't restore the context from virtual
> stack because the stack can hardly be accessed with MMU OFF.
> 
> For now, disable VMAP stack when CONFIG_ADB_PMU is selected.

Applied to powerpc/fixes.

[1/1] powerpc/32s: Disable VMAP stack which CONFIG_ADB_PMU
      https://git.kernel.org/powerpc/c/4a133eb351ccc275683ad49305d0b04dde903733

cheers

Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECFBC432BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 13:29:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B9160EB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 13:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61B9160EB0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gx0tG0dysz3cbn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 23:29:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ellerman.id.au; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gx0kh5x9sz3c6q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2021 23:22:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kf47Ktz9t1Q;
 Fri, 27 Aug 2021 23:22:34 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Joel Stanley <joel@jms.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20210817045407.2445664-1-joel@jms.id.au>
References: <20210817045407.2445664-1-joel@jms.id.au>
Subject: Re: [PATCH v2 0/3] powerpc: mpc855_ads defconfig fixes
Message-Id: <163007013701.52768.10491223554831404392.b4-ty@ellerman.id.au>
Date: Fri, 27 Aug 2021 23:15:37 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 17 Aug 2021 14:24:04 +0930, Joel Stanley wrote:
> v2: fix typos, split out mtd fix from savedefconfig patch
> 
> The first patch fixes a build warning I noticed when testing something
> unrelated.
> 
> The second fixes a regression where the MTD partition support dropped out
> of the config. I have enabled the dependency so this is still part of
> the config.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/config: Fix IPV6 warning in mpc855_ads
      https://git.kernel.org/powerpc/c/c5ac55b6cbc604ad4144c380feae20f69453df91
[2/3] powerpc/config: Renable MTD_PHYSMAP_OF
      https://git.kernel.org/powerpc/c/d0e28a6145c3455b69991245e7f6147eb914b34a
[3/3] powerpc/configs: Regenerate mpc885_ads_defconfig
      https://git.kernel.org/powerpc/c/87e0d46bf68913f4c87dba94aadc00da658a874b

cheers

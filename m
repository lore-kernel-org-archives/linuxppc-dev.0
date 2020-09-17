Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB6C43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:32:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6802087D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6802087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bsbvn14zxzDqL0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 22:32:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsZVB40lxzDqWr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 21:28:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BsZV71R3lz9sTq; Thu, 17 Sep 2020 21:28:47 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BsZV70C6Jz9sTp; Thu, 17 Sep 2020 21:28:46 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200908125850.407939-1-mpe@ellerman.id.au>
References: <20200908125850.407939-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64: Make VDSO32 track COMPAT on 64-bit
Message-Id: <160034211494.3342081.16977957933269532766.b4-ty@ellerman.id.au>
Date: Thu, 17 Sep 2020 21:28:46 +1000 (AEST)
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
Cc: christophe.leroy@c-s.fr, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 8 Sep 2020 22:58:50 +1000, Michael Ellerman wrote:
> When we added the VDSO32 kconfig symbol, which controls building of
> the 32-bit VDSO, we made it depend on CPU_BIG_ENDIAN (for 64-bit).
> 
> That was because back then COMPAT was always enabled for 64-bit, so
> depending on it would have left the 32-bit VDSO always enabled, which
> we didn't want.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64: Make VDSO32 track COMPAT on 64-bit
      https://git.kernel.org/powerpc/c/231b232df8f67e7d37af01259c21f2a131c3911e

cheers

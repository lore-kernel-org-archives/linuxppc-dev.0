Return-Path: <SRS0=Xeze=HO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E0C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:34:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEEE64E2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEEE64E2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DcDyW743gzDx2X
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 11:34:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DcDf51wkkzDwnW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 11:19:57 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DcDf45KfPz9sVX; Fri, 12 Feb 2021 11:19:56 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>, msuchanek@suse.de,
 Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612898425.git.christophe.leroy@csgroup.eu>
References: <cover.1612898425.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v6 0/2] powerpc/32: Implement C syscall entry/exit
 (complement)
Message-Id: <161308904799.3606979.14603109971130321553.b4-ty@ellerman.id.au>
Date: Fri, 12 Feb 2021 11:19:56 +1100 (AEDT)
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

On Tue, 9 Feb 2021 19:29:26 +0000 (UTC), Christophe Leroy wrote:
> This series implements C syscall entry/exit for PPC32. It reuses
> the work already done for PPC64.
> 
> This series is based on today's next-test (f538b53fd47a) where main patchs from v5 are merged in.
> 
> The first patch is important for performance.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/syscall: Do not check unsupported scv vector on PPC32
      https://git.kernel.org/powerpc/c/b966f2279048ee9f30d83ef8568b99fa40917c54
[2/3] powerpc/32: Handle bookE debugging in C in syscall entry/exit
      https://git.kernel.org/powerpc/c/d524dda719f06967db4d3ba519edf9267f84c155
[3/3] powerpc/syscall: Avoid storing 'current' in another pointer
      https://git.kernel.org/powerpc/c/5b90b9661a3396e00f6e8bcbb617a0787fb683d0

cheers

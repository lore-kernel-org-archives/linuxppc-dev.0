Return-Path: <SRS0=BXao=BG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92235C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 07:42:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADFD2072E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 07:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADFD2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFWx00MNmzDqT4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 17:42:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFWZz6HDJzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 17:26:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BFWZy1TfDz9sRN; Mon, 27 Jul 2020 17:26:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Bill Wendling <morbo@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <191c67db31264b69cf6b566fd69851beb3dd0abb.1595630874.git.morbo@google.com>
References: <CAGG=3QW4=SmOEY=9mdtZUPBBvHHzVD4UN7hAz9wC83ctr8XsXQ@mail.gmail.com>
 <191c67db31264b69cf6b566fd69851beb3dd0abb.1595630874.git.morbo@google.com>
Subject: Re: [PATCH v2] powerpc/64s: allow for clang's objdump differences
Message-Id: <159583478689.602200.16183439706875321426.b4-ty@ellerman.id.au>
Date: Mon, 27 Jul 2020 17:26:49 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 24 Jul 2020 15:49:01 -0700, Bill Wendling wrote:
> Clang's objdump emits slightly different output from GNU's objdump,
> causing a list of warnings to be emitted during relocatable builds.
> E.g., clang's objdump emits this:
> 
>    c000000000000004: 2c 00 00 48  b  0xc000000000000030
>    ...
>    c000000000005c6c: 10 00 82 40  bf 2, 0xc000000000005c7c
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s: allow for clang's objdump differences
      https://git.kernel.org/powerpc/c/faedc380129501bdd7f669bf14e9c7ee3e7a2feb

cheers

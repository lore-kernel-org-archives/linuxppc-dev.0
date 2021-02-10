Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB2C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:53:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAAD64E6C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAAD64E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbN6b3bSlzDvbt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 01:53:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKYb1XdrzDslj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:55 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKYY6lXsz9sWg; Wed, 10 Feb 2021 23:57:53 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, rppt@kernel.org,
 paulus@samba.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <20210202093746.5198-1-unixbhaskar@gmail.com>
References: <20210202093746.5198-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] arch: powerpc: kernel: Fix the spelling mismach to
 mismatch in head.44x.S
Message-Id: <161296171992.3178259.17393013457574476712.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:53 +1100 (AEDT)
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
Cc: rdunlap@infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2 Feb 2021 15:07:46 +0530, Bhaskar Chowdhury wrote:
> s/mismach/mismatch/

Applied to powerpc/next.

[1/1] powerpc/44x: Fix a spelling mismach to mismatch in head_44x.S
      https://git.kernel.org/powerpc/c/ea7826583f5ed7abca97e6e56441caadcbbd957a

cheers

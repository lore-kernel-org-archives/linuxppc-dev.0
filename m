Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573C2C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:12:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE76164DEE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE76164DEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbKt748jzzDvbT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 00:12:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKY40wRBzDrBq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:28 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKY2037Wz9sWR; Wed, 10 Feb 2021 23:57:24 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <72c7b9879e2e2e6f5c27dadda6486386c2b50f23.1612612022.git.christophe.leroy@csgroup.eu>
References: <72c7b9879e2e2e6f5c27dadda6486386c2b50f23.1612612022.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/32s: Change mfsrin() into a static inline
 function
Message-Id: <161296172491.3178259.6717759918429909544.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:24 +1100 (AEDT)
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

On Sat, 6 Feb 2021 11:47:26 +0000 (UTC), Christophe Leroy wrote:
> mfsrin() is a macro.
> 
> Change in into an inline function to avoid conflicts in KVM
> and make it more evolutive.

Applied to powerpc/next.

[1/3] powerpc/32s: Change mfsrin() into a static inline function
      https://git.kernel.org/powerpc/c/fd659e8f2c6d1e1e96fd5bdb515518801cd02012
[2/3] powerpc/32s: mfsrin()/mtsrin() become mfsr()/mtsr()
      https://git.kernel.org/powerpc/c/179ae57dbad1b9a83eec376aa44d54fc24352e37
[3/3] powerpc/32s: Allow constant folding in mtsr()/mfsr()
      https://git.kernel.org/powerpc/c/b842d131c7983f8f0b9c9572c073130b5f2bcf11

cheers

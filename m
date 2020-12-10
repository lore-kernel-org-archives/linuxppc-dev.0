Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22BEC4361B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 12:37:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A280523B87
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 12:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A280523B87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsD292nHwzDqKP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 23:37:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsBXW67QLzDqc4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 22:29:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CsBXV5p1rz9sWy; Thu, 10 Dec 2020 22:29:45 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alastair D'Silva <alastair@d-silva.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <ceede82fadf37f3b8275e61fcf8cf29a3e2ec7fe.1602351011.git.christophe.leroy@csgroup.eu>
References: <ceede82fadf37f3b8275e61fcf8cf29a3e2ec7fe.1602351011.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Fix verification of MMU_FTR_TYPE_44x
Message-Id: <160756607012.1313423.11395822390772039188.b4-ty@ellerman.id.au>
Date: Thu, 10 Dec 2020 22:29:45 +1100 (AEDT)
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

On Sat, 10 Oct 2020 17:30:59 +0000 (UTC), Christophe Leroy wrote:
> MMU_FTR_TYPE_44x cannot be checked by cpu_has_feature()
> 
> Use mmu_has_feature() instead

Applied to powerpc/next.

[1/1] powerpc/mm: Fix verification of MMU_FTR_TYPE_44x
      https://git.kernel.org/powerpc/c/17179aeb9d34cc81e1a4ae3f85e5b12b13a1f8d0

cheers

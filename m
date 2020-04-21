Return-Path: <SRS0=D6Rn=6F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A9C54FC9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 15:00:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F7B206D6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 15:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F7B206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4966Dx2Jl0zDqRh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2020 01:00:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49656c6zpMzDqtv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2020 00:09:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49656b64Szz9sSx; Wed, 22 Apr 2020 00:09:43 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8d0ea29db5aefd0d94fa4b6ca6124c68998f3c6a
In-Reply-To: <1587016720.2275.1047.camel@hbabu-laptop>
To: Haren Myneni <haren@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v11 01/14] powerpc/xive: Define
 xive_native_alloc_irq_on_chip()
Message-Id: <49656b64Szz9sSx@ozlabs.org>
Date: Wed, 22 Apr 2020 00:09:43 +1000 (AEST)
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
Cc: mikey@neuling.org, ajd@linux.ibm.com, frederic.barrat@fr.ibm.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, hch@infradead.org,
 oohall@gmail.com, clg@kaod.org, herbert@gondor.apana.org.au,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 srikar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-04-16 at 05:58:40 UTC, Haren Myneni wrote:
> 
> This function allocates IRQ on a specific chip. VAS needs per chip
> IRQ allocation and will have IRQ handler per VAS instance.
> 
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8d0ea29db5aefd0d94fa4b6ca6124c68998f3c6a

cheers

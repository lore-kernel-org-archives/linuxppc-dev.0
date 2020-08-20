Return-Path: <SRS0=8mJi=B6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C973FC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2020 13:39:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4210320674
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2020 13:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4210320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BXQjM4fhqzDqGh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2020 23:39:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BXQXm68VZzDr1R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2020 23:31:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BXQXl2v1Rz9sV4; Thu, 20 Aug 2020 23:31:34 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: oohall@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20200819130741.16769-1-fbarrat@linux.ibm.com>
References: <20200819130741.16769-1-fbarrat@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/pci: Fix typo when releasing DMA resources
Message-Id: <159793027430.2366922.16353476973955365668.b4-ty@ellerman.id.au>
Date: Thu, 20 Aug 2020 23:31:34 +1000 (AEST)
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

On Wed, 19 Aug 2020 15:07:41 +0200, Frederic Barrat wrote:
> Fix typo introduced during recent code cleanup, which could lead to
> silently not freeing resources or oops message (on PCI hotplug or CAPI
> reset).
> Only impacts ioda2, the code path for ioda1 is correct.

Applied to powerpc/fixes.

[1/1] powerpc/powernv/pci: Fix possible crash when releasing DMA resources
      https://git.kernel.org/powerpc/c/e17a7c0e0aebb956719ce2a8465f649859c2da7d

cheers

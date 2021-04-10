Return-Path: <SRS0=Z3yz=JH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DAC433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:33:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5033B610A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5033B610A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHcv20KHBz3f1y
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 00:33:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHcp968Bvz30BP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 00:29:37 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FHcp94YMkz9t0Y; Sun, 11 Apr 2021 00:29:37 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210316010938.525657-1-mpe@ellerman.id.au>
References: <20210316010938.525657-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Only register vio drivers if vio bus
 exists
Message-Id: <161806492631.1467223.14577691281347799326.b4-ty@ellerman.id.au>
Date: Sun, 11 Apr 2021 00:28:46 +1000
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
Cc: pmenzel@molgen.mpg.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 16 Mar 2021 12:09:38 +1100, Michael Ellerman wrote:
> The vio bus is a fake bus, which we use on pseries LPARs (guests) to
> discover devices provided by the hypervisor. There's no need or sense
> in creating the vio bus on bare metal systems.
> 
> Which is why commit 4336b9337824 ("powerpc/pseries: Make vio and
> ibmebus initcalls pseries specific") made the initialisation of the
> vio bus only happen in LPARs.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries: Only register vio drivers if vio bus exists
      https://git.kernel.org/powerpc/c/11d92156f7a862091009d7655d19c1e7de37fc7a

cheers

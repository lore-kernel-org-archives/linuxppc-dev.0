Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DCCE706FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:34:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rrqwk2QMCz3dR4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Sep 2023 19:34:14 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rrqvh1bQlz2ymM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2023 19:33:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rrqvh0PtKz4xPQ;
	Thu, 21 Sep 2023 19:33:20 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Gray <bgray@linux.ibm.com>
In-Reply-To: <20230830044238.578840-1-bgray@linux.ibm.com>
References: <20230830044238.578840-1-bgray@linux.ibm.com>
Subject: Re: [PATCH] powerpc/configs: Set more PPC debug configs
Message-Id: <169528860034.876432.10198531512850599576.b4-ty@ellerman.id.au>
Date: Thu, 21 Sep 2023 19:30:00 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 30 Aug 2023 14:42:38 +1000, Benjamin Gray wrote:
> Add more config options that wouldn't be done by the generic debug
> config in kernel/configs/debug.config
> 
> CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
> 	Adds an initialized check on each (cpu|mmu)_has_feature()
> 
> CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
> 	Adds some extra checks around IRQ mask manipulation
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/configs: Set more PPC debug configs
      https://git.kernel.org/powerpc/c/ff25ad0aa280012eda5699713a9f0b468a1d6e4e

cheers

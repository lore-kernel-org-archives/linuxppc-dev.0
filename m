Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BAFC001B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Aug 2023 06:06:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLxHw5M3fz3djj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Aug 2023 16:06:04 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLxFJ6FtHz2ygv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2023 16:03:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLxFJ5K26z4wy9;
	Thu, 10 Aug 2023 16:03:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20230524060821.148015-1-npiggin@gmail.com>
References: <20230524060821.148015-1-npiggin@gmail.com>
Subject: Re: [PATCH 0/4] powerpc: mm_cpumask cleanups and lazy tlb mm
Message-Id: <169164734544.180689.17044385714692075276.b4-ty@ellerman.id.au>
Date: Thu, 10 Aug 2023 16:02:25 +1000
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

On Wed, 24 May 2023 16:08:17 +1000, Nicholas Piggin wrote:
> In the process of doing patch 4, I found a few things we could improve
> and tighten up with mm_cpumask handling, so added those first. They're
> mostly just debugging, no real fixes or dependency on patch 4 there.
> 
> Thanks,
> Nick
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc: Account mm_cpumask and active_cpus in init_mm
      https://git.kernel.org/powerpc/c/c3c2e93753484bb4e935ed8205c1f569907f5970
[2/4] powerpc/64s: Use dec_mm_active_cpus helper
      https://git.kernel.org/powerpc/c/f74b2a6c01a0b319070ccee7dea0cc4dad694041
[3/4] powerpc: Add mm_cpumask warning when context switching
      https://git.kernel.org/powerpc/c/177255afb40548fdf504384b361d18d6cbe35d1e
[4/4] powerpc/64s/radix: combine final TLB flush and lazy tlb mm shootdown IPIs
      https://git.kernel.org/powerpc/c/e43c0a0c3c2870e1ee29519dc249471adf19ab5f

cheers

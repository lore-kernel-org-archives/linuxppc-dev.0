Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E6EEE4993
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 12:13:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW4qY1kF2z3gsD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 22:13:13 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW4cq6lkLz3c53
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2023 22:03:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cq5LxTz4x2X;
	Wed, 23 Aug 2023 22:03:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <0a667b7c2e05d3cf41ecd38f33cc334083a61c8d.1692282396.git.christophe.leroy@csgroup.eu>
References: <0a667b7c2e05d3cf41ecd38f33cc334083a61c8d.1692282396.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/47x: Remove early_init_mmu_47x() to fix no previous prototype
Message-Id: <169279175576.797584.1515002714869080486.b4-ty@ellerman.id.au>
Date: Wed, 23 Aug 2023 21:55:55 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 17 Aug 2023 16:26:44 +0200, Christophe Leroy wrote:
> 4xx/iss476-smp_defconfig leads to:
> 
>   CC      arch/powerpc/mm/nohash/tlb.o
> arch/powerpc/mm/nohash/tlb.c:322:13: error: no previous prototype for 'early_init_mmu_47x' [-Werror=missing-prototypes]
>   322 | void __init early_init_mmu_47x(void)
>       |             ^~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/47x: Remove early_init_mmu_47x() to fix no previous prototype
      https://git.kernel.org/powerpc/c/ed05c71a574235aec3418d2b5c94f24ae84cc2db

cheers

Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12CFC001B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Aug 2023 06:04:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLxFq1pY2z3cYj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Aug 2023 16:04:15 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLxFH0Bz0z2ygv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2023 16:03:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLxFF14zzz4wqX;
	Thu, 10 Aug 2023 16:03:45 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20230727122720.2558065-1-arnd@kernel.org>
References: <20230727122720.2558065-1-arnd@kernel.org>
Subject: Re: [PATCH] powerpc: address missing-prototypes warnings
Message-Id: <169164734546.180689.4715496668121527837.b4-ty@ellerman.id.au>
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
Cc: Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 27 Jul 2023 14:26:50 +0200, Arnd Bergmann wrote:
> There are a few warnings in powerpc64 defconfig builds after -Wmissing-prototypes
> gets promoted from W=1 to the default warning set:
> 
> arch/powerpc/mm/book3s64/pgtable.c:422:6: error: no previous prototype for 'arch_report_meminfo' [-Werror=missing-prototypes]
> arch/powerpc/mm/init_64.c:311:12: error: no previous prototype for '__vmemmap_free' [-Werror=missing-prototypes]
> arch/powerpc/platforms/cell/ras.c:275:5: error: no previous prototype for 'cbe_sysreset_hack' [-Werror=missing-prototypes]
> arch/powerpc/platforms/cell/spu_manage.c:29:21: error: no previous prototype for 'spu_devnode' [-Werror=missing-prototypes]
> arch/powerpc/platforms/pasemi/time.c:12:17: error: no previous prototype for 'pas_get_boot_time' [-Werror=missing-prototypes]
> arch/powerpc/platforms/powermac/feature.c:1532:13: error: no previous prototype for 'g5_phy_disable_cpu1' [-Werror=missing-prototypes]
> arch/powerpc/platforms/86xx/pic.c:28:13: error: no previous prototype for 'mpc86xx_init_irq' [-Werror=missing-prototypes]
> drivers/pci/pci-sysfs.c:936:13: error: no previous prototype for 'pci_adjust_legacy_attr' [-Werror=missing-prototypes]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: address missing-prototypes warnings
      https://git.kernel.org/powerpc/c/54f30b83fe627453082f15d83d7820b28b2d24bb

cheers

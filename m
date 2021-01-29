Return-Path: <SRS0=ow3e=HA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCF5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 11:53:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D3064EDE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 11:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D3064EDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRwhG33d3zDrQH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 22:53:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DRwbR6b6fzDqVW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2021 22:48:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=k/4lvtNL; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DRwbR1t80z9rx8;
 Fri, 29 Jan 2021 22:48:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1611920931;
 bh=9mvhq6e3q54eqU+ls5klwsLWQlHmF+qb2ZXsCQd1h4k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=k/4lvtNLHl+scPyWXQcIGKkR9vjOv6X6EYDd7hUuDB8oZKHFJqgdySSbTqocZ6NQ7
 Yj6V3bJg5wEPVhfOlPSd1hcXc5C5aeyH0dSnK5qoFFCZGsd42wzb4rkro2NEh7zzql
 qRAa9XdA3hJzm+Hsa+PuNTbh1dZZJkhpjKo2fkyjkcWg15aXlks3C7fbDih2VC4xCM
 zWydrgMTvs2LokyE50EiSqYqC3hMJQwgG4OgVIsNXL301ddwJ2geNcuAZR+y2ArI30
 gCOfNApD4ehac2wkJlYnfCs/mH2cYm+ywgm4nW1WT3fqJp6/l+DxaojEt/xIW5zYaH
 JSGCgOYmWBGmA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chengyang Fan <cy.fan@huawei.com>
Subject: Re: [PATCH] powerpc: remove unneeded semicolons
In-Reply-To: <20210125095338.1719405-1-cy.fan@huawei.com>
References: <20210125095338.1719405-1-cy.fan@huawei.com>
Date: Fri, 29 Jan 2021 22:48:50 +1100
Message-ID: <87v9bgc6al.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: joe@perches.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Chengyang Fan <cy.fan@huawei.com> writes:
> Remove superfluous semicolons after function definitions.

Is there a good reason why?

I realise they're superfluous, but they're also harmless as far as I'm
aware.

cheers

>  arch/powerpc/include/asm/book3s/32/mmu-hash.h       |  2 +-
>  arch/powerpc/include/asm/book3s/64/mmu.h            |  2 +-
>  arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/tlbflush.h       |  2 +-
>  arch/powerpc/include/asm/firmware.h                 |  2 +-
>  arch/powerpc/include/asm/kvm_ppc.h                  |  6 +++---
>  arch/powerpc/include/asm/paca.h                     |  6 +++---
>  arch/powerpc/include/asm/rtas.h                     |  2 +-
>  arch/powerpc/include/asm/setup.h                    |  6 +++---
>  arch/powerpc/include/asm/simple_spinlock.h          |  4 ++--
>  arch/powerpc/include/asm/smp.h                      |  2 +-
>  arch/powerpc/include/asm/xmon.h                     |  4 ++--
>  arch/powerpc/kernel/prom.c                          |  2 +-
>  arch/powerpc/kernel/setup.h                         | 12 ++++++------
>  arch/powerpc/platforms/powernv/subcore.h            |  2 +-
>  arch/powerpc/platforms/pseries/pseries.h            |  2 +-
>  16 files changed, 29 insertions(+), 29 deletions(-)

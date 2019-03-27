Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDDC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 11:41:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F02120700
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 11:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F02120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TmL02ztPzDqR1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 22:41:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TmHc3SqZzDqF5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 22:39:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44TmHZ63c9z9sP1;
 Wed, 27 Mar 2019 22:39:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'IBM Power Virtual
 Accelerator Switchboard'
In-Reply-To: <20190325233521.31094-1-joe@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325233521.31094-1-joe@perches.com>
Date: Wed, 27 Mar 2019 22:39:11 +1100
Message-ID: <87k1gko8bk.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joe Perches <joe@perches.com> writes:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
>
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.

I think it was removed before the final submission.

> The commits that added and if found renamed or removed the file pattern
> are shown below.
>
> Please fix this defect appropriately.

Sukadev can you send me a patch to fix it please?

cheers

> 1: ---------------------------------------------------------------------------
>
> linux-next MAINTAINERS section:
>
> 	7396	IBM Power Virtual Accelerator Switchboard
> 	7397	M:	Sukadev Bhattiprolu
> 	7398	L:	linuxppc-dev@lists.ozlabs.org
> 	7399	S:	Supported
> 	7400	F:	arch/powerpc/platforms/powernv/vas*
> 	7401	F:	arch/powerpc/platforms/powernv/copy-paste.h
> 	7402	F:	arch/powerpc/include/asm/vas.h
> -->	7403	F:	arch/powerpc/include/uapi/asm/vas.h
>
> 2: ---------------------------------------------------------------------------
>
> The most recent commit that added or modified file pattern 'arch/powerpc/include/uapi/asm/vas.h':
>
> commit 4dea2d1a927c61114a168d4509b56329ea6effb7
> Author: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date:   Mon Aug 28 23:23:33 2017 -0700
>
>     powerpc/powernv/vas: Define vas_init() and vas_exit()
>     
>     Implement vas_init() and vas_exit() functions for a new VAS module.
>     This VAS module is essentially a library for other device drivers
>     and kernel users of the NX coprocessors like NX-842 and NX-GZIP.
>     In the future this will be extended to add support for user space
>     to access the NX coprocessors.
>     
>     VAS is currently only supported with 64K page size.
>     
>     Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
>  .../devicetree/bindings/powerpc/ibm,vas.txt        |  22 +++
>  MAINTAINERS                                        |   8 ++
>  arch/powerpc/platforms/powernv/Kconfig             |  14 ++
>  arch/powerpc/platforms/powernv/Makefile            |   1 +
>  arch/powerpc/platforms/powernv/vas-window.c        |  19 +++
>  arch/powerpc/platforms/powernv/vas.c               | 151 +++++++++++++++++++++
>  arch/powerpc/platforms/powernv/vas.h               |   2 +
>  7 files changed, 217 insertions(+)
>
> 3: ---------------------------------------------------------------------------
>
> No commit with file pattern 'arch/powerpc/include/uapi/asm/vas.h' was found

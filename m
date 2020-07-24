Return-Path: <SRS0=CqhW=BD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E97C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:51:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC66206D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC66206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCsbG3wxRzDrP1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 00:51:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCqgV2Z15zDqBG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 23:24:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BCqgR2d6Zz9sSt; Fri, 24 Jul 2020 23:24:51 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Jordan Niethe <jniethe5@gmail.com>
In-Reply-To: <20200525025923.19843-1-jniethe5@gmail.com>
References: <20200525025923.19843-1-jniethe5@gmail.com>
Subject: Re: [PATCH 1/5] powerpc sstep: Add tests for prefixed integer
 load/stores
Message-Id: <159559697015.1657499.14411731288554838877.b4-ty@ellerman.id.au>
Date: Fri, 24 Jul 2020 23:24:50 +1000 (AEST)
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
Cc: alistair@popple.id.au, bala24@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 25 May 2020 12:59:19 +1000, Jordan Niethe wrote:
> Add tests for the prefixed versions of the integer load/stores that are
> currently tested. This includes the following instructions:
>   * Prefixed Load Doubleword (pld)
>   * Prefixed Load Word and Zero (plwz)
>   * Prefixed Store Doubleword (pstd)
> 
> Skip the new tests if ISA v3.1 is unsupported.

Applied to powerpc/next.

[1/5] powerpc/sstep: Add tests for prefixed integer load/stores
      https://git.kernel.org/powerpc/c/b6b54b42722a2393056c891c0d05cd8cc40eb776
[2/5] powerpc/sstep: Add tests for prefixed floating-point load/stores
      https://git.kernel.org/powerpc/c/0396de6d8561c721b03fce386eb9682b37a26013
[3/5] powerpc/sstep: Set NIP in instruction emulation tests
      https://git.kernel.org/powerpc/c/1c89cf7fbed36f078b20fd47d308b4fc6dbff5f6
[4/5] powerpc/sstep: Let compute tests specify a required cpu feature
      https://git.kernel.org/powerpc/c/301ebf7d69f6709575d137a41a0291f69f343aed
[5/5] powerpc/sstep: Add tests for Prefixed Add Immediate
      https://git.kernel.org/powerpc/c/4f825900786e1c24e4c48622e12eb493a6cd27b6

cheers

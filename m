Return-Path: <SRS0=3A4D=LA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E6C47096
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 12:18:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4294608FE
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 12:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4294608FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FybBc0lvhz3fXH
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 22:18:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fyb3R2110z3bt1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jun 2021 22:12:19 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Fyb3Q1TNBz9t10; Sun,  6 Jun 2021 22:12:17 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org,
 Sathvika Vasireddy <sathvika@linux.vnet.ibm.com>
In-Reply-To: <cover.1620727160.git.sathvika@linux.vnet.ibm.com>
References: <cover.1620727160.git.sathvika@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/2] powerpc/sstep: Add emulation support and tests for
 'setb' instruction
Message-Id: <162298132057.2353459.1382383462872014977.b4-ty@ellerman.id.au>
Date: Sun, 06 Jun 2021 22:08:40 +1000
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
Cc: naveen.n.rao@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 11 May 2021 07:18:31 -0500, Sathvika Vasireddy wrote:
> This patchset adds emulation support and tests for setb instruction.
> Test cases are written to test different CR fields with different
> bits set in each field.
> 
> v1->v2:
>   - Extract all the bits of the CR field (bfa) and check if the
>     LT, GT bits of that CR field (bfa) are set.
>   - Place 'setb' emulation code after 'mfcr' instruction emulation.
>   - Add 'cpu_feature' in the selftests patch to restrict them to ISA v3.0
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/sstep: Add emulation support for ‘setb’ instruction
      https://git.kernel.org/powerpc/c/5b75bd763d369e43e6d09e85eaea22fde37c0e89
[2/2] powerpc/sstep: Add tests for setb instruction
      https://git.kernel.org/powerpc/c/60060d704c55a9450208b8f0bc5026df9d4ab1d6

cheers

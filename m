Return-Path: <SRS0=XWqB=PF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83428C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Oct 2021 12:33:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A1E6125F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Oct 2021 12:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17A1E6125F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXKDC3kYNz3cDh
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Oct 2021 23:33:15 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXKCn1DZTz2yYd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Oct 2021 23:32:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HXKCm3thVz4xbV;
 Sun, 17 Oct 2021 23:32:52 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 jolsa@kernel.org, acme@kernel.org
In-Reply-To: <20211007065505.27809-1-atrajeev@linux.vnet.ibm.com>
References: <20211007065505.27809-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [V3 0/4] powerpc/perf: Add instruction and data address registers
 to extended regs
Message-Id: <163447392279.1159469.8742015936516312769.b4-ty@ellerman.id.au>
Date: Sun, 17 Oct 2021 23:32:02 +1100
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
Cc: kjain@linux.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, rnsastry@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 7 Oct 2021 12:25:01 +0530, Athira Rajeev wrote:
> Patch set adds PMU registers namely Sampled Instruction Address Register
> (SIAR) and Sampled Data Address Register (SDAR) as part of extended regs
> in PowerPC. These registers provides the instruction/data address and
> adding these to extended regs helps in debug purposes.
> 
> Patch 1/4 and 2/4 refactors the existing macro definition of
> PERF_REG_PMU_MASK_300 and PERF_REG_PMU_MASK_31 to make it more
> readable.
> Patch 3/4 adds SIAR and SDAR as part of the extended regs mask.
> Patch 4/4 includes perf tools side changes to add the SPRs to
> sample_reg_mask to use with -I? option.
> 
> [...]

Patches 1 and 3 applied to powerpc/next.

[1/4] powerpc/perf: Refactor the code definition of perf reg extended mask
      https://git.kernel.org/powerpc/c/02b182e67482d9167a13a0ff19b55037b70b21ad
[3/4] powerpc/perf: Expose instruction and data address registers as part of extended regs
      https://git.kernel.org/powerpc/c/29908bbf7b8960d261dfdd428bbaa656275e80f3

cheers

Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB003C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 05:35:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8015F206A4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 05:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8015F206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49gzNN4mWYzDq9T
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 15:35:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzDc1RZVzDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzDc0FYzz9sTG; Tue,  9 Jun 2020 15:28:31 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>
In-Reply-To: <20200521014341.29095-1-alistair@popple.id.au>
References: <20200521014341.29095-1-alistair@popple.id.au>
Subject: Re: [PATCH v3 0/7] Base support for POWER10
Message-Id: <159168035553.1381411.323672966899358346.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:28:31 +1000 (AEST)
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
Cc: aneesh.kumar@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 21 May 2020 11:43:34 +1000, Alistair Popple wrote:
> This series brings together several previously posted patches required for
> POWER10 support and introduces a new patch enabling POWER10 architected
> mode to enable booting as a POWER10 pseries guest.
> 
> It includes support for enabling facilities related to MMA and prefix
> instructions.
> 
> [...]

Patches 1-3 and 5-7 applied to powerpc/next.

[1/7] powerpc: Add new HWCAP bits
      https://git.kernel.org/powerpc/c/ee988c11acf6f9464b7b44e9a091bf6afb3b3a49
[2/7] powerpc: Add support for ISA v3.1
      https://git.kernel.org/powerpc/c/3fd5836ee801ab9ac5b314c26550e209bafa5eaa
[3/7] powerpc/dt_cpu_ftrs: Advertise support for ISA v3.1 if selected
      https://git.kernel.org/powerpc/c/43d0d37acbe40a9a93d9891ca670638cd22116b1
[5/7] powerpc/dt_cpu_ftrs: Enable Prefixed Instructions
      https://git.kernel.org/powerpc/c/c63d688c3dabca973c5a7da73d17422ad13f3737
[6/7] powerpc/dt_cpu_ftrs: Add MMA feature
      https://git.kernel.org/powerpc/c/87939d50e5888bd78478d9aa9455f56b919df658
[7/7] powerpc: Add POWER10 architected mode
      https://git.kernel.org/powerpc/c/a3ea40d5c7365e7e5c7c85b6f30b15142b397571

cheers

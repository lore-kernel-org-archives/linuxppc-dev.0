Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEB2C43461
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 14:35:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F1622251
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 14:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F1622251
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bml140dTkzDqVQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 00:35:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjWJ120ZzDqKV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:27:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BmjWH5DJ1z9sVZ; Wed,  9 Sep 2020 23:27:55 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjWH22fpz9sTN; Wed,  9 Sep 2020 23:27:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200819015727.1977134-1-mpe@ellerman.id.au>
References: <20200819015727.1977134-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/9] selftests/powerpc: Make using_hash_mmu() work on Cell
 & PowerMac
Message-Id: <159965717317.808686.14834695269183706919.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:27:55 +1000 (AEST)
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 19 Aug 2020 11:57:19 +1000, Michael Ellerman wrote:
> These platforms don't show the MMU in /proc/cpuinfo, but they always
> use hash, so teach using_hash_mmu() that.

Applied to powerpc/next.

[1/9] selftests/powerpc: Make using_hash_mmu() work on Cell & PowerMac
      https://git.kernel.org/powerpc/c/34c103342be3f9397e656da7c5cc86e97b91f514
[2/9] selftests/powerpc: Give the bad_accesses test longer to run
      https://git.kernel.org/powerpc/c/17c98a541dc9bb1162877af41cddbdca043f9a59
[3/9] selftests/powerpc: Move set_dscr() into rfi_flush.c
      https://git.kernel.org/powerpc/c/d89002397cfb2b65267d6688fe671ee1cf7c5f0d
[4/9] selftests/powerpc: Include asm/cputable.h from utils.h
      https://git.kernel.org/powerpc/c/178282a054dced1a08a9683d41ac08cbace2b2fe
[5/9] selftests/powerpc: Don't run DSCR tests on old systems
      https://git.kernel.org/powerpc/c/4c3c3c502575556c4bc1b401235e641863b1bce6
[6/9] selftests/powerpc: Skip security tests on older CPUs
      https://git.kernel.org/powerpc/c/3a31518a242dcb262b008d3bb5d4b1cf50cf4026
[7/9] selftests/powerpc: Skip L3 bank test on older CPUs
      https://git.kernel.org/powerpc/c/4871a10b7b5f6b0632bff229884dad1cb1e8dc37
[8/9] selftests/powerpc: Don't touch VMX/VSX on older CPUs
      https://git.kernel.org/powerpc/c/09275d717d1b2d7d5ed91f2140bb34246514a1b4
[9/9] selftests/powerpc: Properly handle failure in switch_endian_test
      https://git.kernel.org/powerpc/c/003d6f5fd2cc3b529f3e6c529bc4bb0792930212

cheers

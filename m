Return-Path: <SRS0=fR6Q=BJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ED7C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:32:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A33206D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A33206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHWYq08fSzDr7P
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 23:32:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHVd2316jzDqyY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 22:50:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BHVd205bcz9sSd; Thu, 30 Jul 2020 22:50:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Sandipan Das <sandipan@linux.ibm.com>
In-Reply-To: <cover.1595821792.git.sandipan@linux.ibm.com>
References: <cover.1595821792.git.sandipan@linux.ibm.com>
Subject: Re: [PATCH v2 0/6] Improvements to pkey tests
Message-Id: <159611327593.1601380.2808031375367591798.b4-ty@ellerman.id.au>
Date: Thu, 30 Jul 2020 22:50:29 +1000 (AEST)
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
Cc: fweimer@redhat.com, linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
 bauerman@linux.ibm.com, aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 27 Jul 2020 09:30:34 +0530, Sandipan Das wrote:
> Based on recent bugs found in the pkey infrastructure, this
> improves the test for execute-disabled pkeys and adds a new
> test for detecting inconsistencies with the pkey reported by
> the signal information upon getting a fault.
> 
> Previous versions can be found at:
> v1: https://lore.kernel.org/linuxppc-dev/cover.1594897099.git.sandipan@linux.ibm.com/
> 
> [...]

Applied to powerpc/next.

[1/6] selftests/powerpc: Move pkey helpers to headers
      https://git.kernel.org/powerpc/c/128d3d0210076232b7d54c361082c8ee17e4b669
[2/6] selftests/powerpc: Add pkey helpers for rights
      https://git.kernel.org/powerpc/c/264d7fccc4711328a19f07e6bd57aee4c68803aa
[3/6] selftests/powerpc: Harden test for execute-disabled pkeys
      https://git.kernel.org/powerpc/c/03634bbf5d8a6f2d97e6150a1b8ff03675badac3
[4/6] selftests/powerpc: Add helper to exit on failure
      https://git.kernel.org/powerpc/c/e3333c599482245d08002725cc1b353e4963fa26
[5/6] selftests/powerpc: Add wrapper for gettid
      https://git.kernel.org/powerpc/c/743f3544fffb9662aaf550c8358a8c1b6fcae707
[6/6] selftests/powerpc: Add test for pkey siginfo verification
      https://git.kernel.org/powerpc/c/c27f2fd1705a7e19ef2dc2b986c0d1cde3c3dbe7

cheers

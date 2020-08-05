Return-Path: <SRS0=7j3x=BP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45003C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 00:46:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38652075A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 00:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38652075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLtGS2pzqzDqNg
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 10:46:08 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLtBC0TjKzDqXZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2020 10:42:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BLtBC02Drz9sPC; Wed,  5 Aug 2020 10:42:27 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BLtBB6KrTz9sT6; Wed,  5 Aug 2020 10:42:26 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200803020719.96114-1-mpe@ellerman.id.au>
References: <20200803020719.96114-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2] selftests/powerpc: Skip vmx/vsx/tar/etc tests on older
 CPUs
Message-Id: <159658812635.351125.100298740346288319.b4-ty@ellerman.id.au>
Date: Wed,  5 Aug 2020 10:42:26 +1000 (AEST)
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

On Mon, 3 Aug 2020 12:07:19 +1000, Michael Ellerman wrote:
> Some of our tests use VSX or newer VMX instructions, so need to be
> skipped on older CPUs to avoid SIGILL'ing.
> 
> Similarly TAR was added in v2.07, and the PMU event used in the stcx
> fail test only works on Power8 or later.

Applied to powerpc/next.

[1/1] selftests/powerpc: Skip vmx/vsx/tar/etc tests on older CPUs
      https://git.kernel.org/powerpc/c/872d11bca9c29ed19595c993b9f552ffe9b63dcb

cheers

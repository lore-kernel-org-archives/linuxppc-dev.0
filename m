Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AD0C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:03:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F9320812
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F9320812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h00q5dpczDqBs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:03:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzF40HkTzDqRp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:28:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49gzF34l5Jz9sTc; Tue,  9 Jun 2020 15:28:55 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzF30vRgz9sSy; Tue,  9 Jun 2020 15:28:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <159057266320.22331.6571453892066907320.stgit@hbathini.in.ibm.com>
References: <159057266320.22331.6571453892066907320.stgit@hbathini.in.ibm.com>
Subject: Re: [PATCH] powerpc/fadump: account for memory_limit while reserving
 memory
Message-Id: <159168034302.1381411.13026447475832378827.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:28:53 +1000 (AEST)
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
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, stable@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>, kbuild test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 27 May 2020 15:14:35 +0530, Hari Bathini wrote:
> If the memory chunk found for reserving memory overshoots the memory
> limit imposed, do not proceed with reserving memory. Default behavior
> was this until commit 140777a3d8df ("powerpc/fadump: consider reserved
> ranges while reserving memory") changed it unwittingly.

Applied to powerpc/next.

[1/1] powerpc/fadump: Account for memory_limit while reserving memory
      https://git.kernel.org/powerpc/c/9a2921e5baca1d25eb8d21f21d1e90581a6d0f68

cheers

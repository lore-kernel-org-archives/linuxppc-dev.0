Return-Path: <SRS0=H3od=DQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E010C433E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2020 06:22:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E13215A4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2020 06:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E13215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C6yfn5BR4zDqX0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2020 17:22:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C6yFP2fZ4zDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2020 17:04:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4C6yFN3dBGz9sVl; Fri,  9 Oct 2020 17:04:07 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>
In-Reply-To: <20200913211904.24472-1-vaibhav@linux.ibm.com>
References: <20200913211904.24472-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: Add PAPR command family to pass-through
 command-set
Message-Id: <160222339640.867048.1720728622452479198.b4-ty@ellerman.id.au>
Date: Fri,  9 Oct 2020 17:04:07 +1100 (AEDT)
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 14 Sep 2020 02:49:04 +0530, Vaibhav Jain wrote:
> Add NVDIMM_FAMILY_PAPR to the list of valid 'dimm_family_mask'
> acceptable by papr_scm. This is needed as since commit
> 92fe2aa859f5 ("libnvdimm: Validate command family indices") libnvdimm
> performs a validation of 'nd_cmd_pkg.nd_family' received as part of
> ND_CMD_CALL processing to ensure only known command families can use
> the general ND_CMD_CALL pass-through functionality.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Add PAPR command family to pass-through command-set
      https://git.kernel.org/powerpc/c/13135b461cf205941308984bd3271ec7d403dc40

cheers

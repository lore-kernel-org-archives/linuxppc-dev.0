Return-Path: <SRS0=BXao=BG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB9C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 07:59:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB9920672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 07:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB9920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFXJF0L5ZzDrB4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 17:59:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFWbB5zCmzDqq0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 17:27:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BFWb71j4Yz9sV7; Mon, 27 Jul 2020 17:26:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, Wei Yongjun <weiyongjun1@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, Hulk Robot <hulkci@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Santosh Sivaraj <santosh@fossix.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200725091949.75234-1-weiyongjun1@huawei.com>
References: <20200725091949.75234-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] powerpc/papr_scm: Make some symbols static
Message-Id: <159583478705.602200.4759051429110235059.b4-ty@ellerman.id.au>
Date: Mon, 27 Jul 2020 17:26:57 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 25 Jul 2020 17:19:49 +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/platforms/pseries/papr_scm.c:97:1: warning:
>  symbol 'papr_nd_regions' was not declared. Should it be static?
> arch/powerpc/platforms/pseries/papr_scm.c:98:1: warning:
>  symbol 'papr_ndr_lock' was not declared. Should it be static?
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Make some symbols static
      https://git.kernel.org/powerpc/c/19a551b254e6c308348a46a65332aa03c01767ed

cheers

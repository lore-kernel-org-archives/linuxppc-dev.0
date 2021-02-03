Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD8C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:28:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD72B64F84
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD72B64F84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW1Dl5BBtzDxX7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 23:28:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09Y2gz9zDwt7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:33 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09X2Ypnz9vFw; Wed,  3 Feb 2021 22:40:30 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 mpe@ellerman.id.au
In-Reply-To: <20210128104143.70668-1-ganeshgr@linux.ibm.com>
References: <20210128104143.70668-1-ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] powerpc/mce: Reduce the size of event arrays
Message-Id: <161235200820.1516112.8436415234351555587.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:30 +1100 (AEDT)
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
Cc: mahesh@linux.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 28 Jan 2021 16:11:42 +0530, Ganesh Goudar wrote:
> Maximum recursive depth of MCE is 4, Considering the maximum depth
> allowed reduce the size of event to 10 from 100. This saves us ~19kB
> of memory and has no fatal consequences.

Applied to powerpc/next.

[1/2] powerpc/mce: Reduce the size of event arrays
      https://git.kernel.org/powerpc/c/17c5cf0fb993e219bda4f53aa9ec90d3cfcf92ab
[2/2] powerpc/mce: Remove per cpu variables from MCE handlers
      https://git.kernel.org/powerpc/c/923b3cf00b3ffc896543bac99affc0fa8553e41a

cheers

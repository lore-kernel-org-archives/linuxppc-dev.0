Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAE5C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:54:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D3360EFE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30D3360EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqTsR6Qmqz3ft8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 23:54:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqThB3ZCBz3cTM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 23:46:18 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GqTh13bTxz9t18; Wed, 18 Aug 2021 23:46:09 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: pratik.r.sampat@gmail.com, rjw@rjwysocki.net,
 "Pratik R. Sampat" <psampat@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org, mpe@ellerman.id.au
In-Reply-To: <20210728120500.87549-1-psampat@linux.ibm.com>
References: <20210728120500.87549-1-psampat@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] cpufreq:powernv: Fix init_chip_info initialization
 in numa=off
Message-Id: <162929392908.3619265.5755055049744911919.b4-ty@ellerman.id.au>
Date: Wed, 18 Aug 2021 23:38:49 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 28 Jul 2021 17:34:59 +0530, Pratik R. Sampat wrote:
> v1: https://lkml.org/lkml/2021/7/26/1509
> Changelog v1-->v2:
> Based on comments from Gautham,
> 1. Included a #define for MAX_NR_CHIPS instead of hardcoding the
> allocation.
> 
> Pratik R. Sampat (1):
>   cpufreq:powernv: Fix init_chip_info initialization in numa=off
> 
> [...]

Applied to powerpc/next.

[1/1] cpufreq:powernv: Fix init_chip_info initialization in numa=off
      https://git.kernel.org/powerpc/c/f34ee9cb2c5ac5af426fee6fa4591a34d187e696

cheers

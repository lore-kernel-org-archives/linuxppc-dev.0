Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C846C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:51:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589BB20760
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589BB20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6wfJ0YgYzDqLy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 23:51:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6vPs1wZ9zDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 22:56:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4B6vPr5SfYz9sVG; Thu, 16 Jul 2020 22:56:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Kajol Jain <kjain@linux.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200709051836.723765-1-kjain@linux.ibm.com>
References: <20200709051836.723765-1-kjain@linux.ibm.com>
Subject: Re: [PATCH v5 0/2] Add cpu hotplug support for powerpc/perf/hv-24x7
Message-Id: <159490401505.3805857.4468239660970858439.b4-ty@ellerman.id.au>
Date: Thu, 16 Jul 2020 22:56:00 +1000 (AEST)
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
Cc: nathanl@linux.ibm.com, ego@linux.vnet.ibm.com, suka@us.ibm.com,
 anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 9 Jul 2020 10:48:34 +0530, Kajol Jain wrote:
> This patchset add cpu hotplug support for hv_24x7 driver by adding
> online/offline cpu hotplug function. It also add sysfs file
> "cpumask" to expose current online cpu that can be used for
> hv_24x7 event count.
> 
> Changelog:
> v4 -> v5
> - Since we are making PMU fail incase hotplug init failed, hence
>   directly adding cpumask attr inside if_attrs rather then creating
>   new attribute_group as suggested by Madhavan Srinivasan.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/perf/hv-24x7: Add cpu hotplug support
      https://git.kernel.org/powerpc/c/1a8f0886a6008c98a926bdeca49f2ef33015a491
[2/2] powerpc/hv-24x7: Add sysfs files inside hv-24x7 device to show cpumask
      https://git.kernel.org/powerpc/c/792f73f747b82f6cb191a323e1f5755d33149b50

cheers

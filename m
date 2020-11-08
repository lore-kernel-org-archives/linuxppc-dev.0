Return-Path: <SRS0=GXYn=EO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43420C388F9
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 10:32:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55611206ED
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 10:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55611206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CTVnM3XTmzDqfd
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 21:32:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CTVjt0Q9czDqdT
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2020 21:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4CTVjq5Hlcz9sSs; Sun,  8 Nov 2020 21:29:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CTVjq39Wnz9sTD; Sun,  8 Nov 2020 21:29:33 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Scott Cheloha <cheloha@linux.ibm.com>
In-Reply-To: <20201105223040.3612663-1-cheloha@linux.ibm.com>
References: <20201105223040.3612663-1-cheloha@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc: topology.h: fix build when CONFIG_NUMA=n
Message-Id: <160483134437.1400561.1353940532618863696.b4-ty@ellerman.id.au>
Date: Sun,  8 Nov 2020 21:29:33 +1100 (AEDT)
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 5 Nov 2020 16:30:40 -0600, Scott Cheloha wrote:
> Add a non-NUMA definition for of_drconf_to_nid_single() to topology.h
> so we have one even if powerpc/mm/numa.c is not compiled.  On a non-NUMA
> kernel the appropriate node id is always first_online_node.

Applied to powerpc/fixes.

[1/1] powerpc/numa: Fix build when CONFIG_NUMA=n
      https://git.kernel.org/powerpc/c/3fb4a8fa28b740709bdd3229b80279957f4d37ed

cheers

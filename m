Return-Path: <SRS0=CfD8=BM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F29C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 14:10:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B427E20759
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 14:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B427E20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKNFZ15bDzDqKv
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 00:10:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKMT866pDzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Aug 2020 23:35:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BKMT82DX9z9sSt; Sun,  2 Aug 2020 23:35:08 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Sandipan Das <sandipan@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <a408c4b8e9a23bb39b539417a21eb0ff47bb5127.1596084858.git.sandipan@linux.ibm.com>
References: <a408c4b8e9a23bb39b539417a21eb0ff47bb5127.1596084858.git.sandipan@linux.ibm.com>
Subject: Re: [PATCH v3] selftests: powerpc: Fix online CPU selection
Message-Id: <159637524083.42190.8594799492751560663.b4-ty@ellerman.id.au>
Date: Sun,  2 Aug 2020 23:35:08 +1000 (AEST)
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
Cc: srikar@linux.vnet.ibm.com, kamalesh@linux.vnet.ibm.com, shiganta@in.ibm.com,
 nasastry@in.ibm.com, harish@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 30 Jul 2020 10:38:46 +0530, Sandipan Das wrote:
> The size of the CPU affinity mask must be large enough for
> systems with a very large number of CPUs. Otherwise, tests
> which try to determine the first online CPU by calling
> sched_getaffinity() will fail. This makes sure that the size
> of the allocated affinity mask is dependent on the number of
> CPUs as reported by get_nprocs_conf().

Applied to powerpc/next.

[1/1] selftests/powerpc: Fix online CPU selection
      https://git.kernel.org/powerpc/c/dfa03fff86027e58c8dba5c03ae68150d4e513ad

cheers

Return-Path: <SRS0=CqhW=BD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70F3C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:24:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B6F20578
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B6F20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCs0B65SczDqmj
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 00:24:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCqgH3hZgzDrN2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 23:24:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BCqgF1RP7z9sSy; Fri, 24 Jul 2020 23:24:40 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <20200626095158.1031507-1-bala24@linux.ibm.com>
References: <20200626095158.1031507-1-bala24@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] Prefixed instruction tests to cover negative cases
Message-Id: <159559697151.1657499.6327582310085368743.b4-ty@ellerman.id.au>
Date: Fri, 24 Jul 2020 23:24:40 +1000 (AEST)
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
Cc: ravi.bangoria@linux.ibm.com, jniethe5@gmail.com, paulus@samba.org,
 sandipan@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 26 Jun 2020 15:21:54 +0530, Balamuruhan S wrote:
> This patchset adds support to test negative scenarios and adds testcase
> for paddi with few fixes. It is based on powerpc/next and on top of
> Jordan's tests for prefixed instructions patchsets,
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-May/211394.html
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-June/211768.html
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/test_emulate_step: Enhancement to test negative scenarios
      https://git.kernel.org/powerpc/c/93c3a0ba2a0863a5c82a518d64044434f82a57f5
[2/4] powerpc/test_emulate_step: Add negative tests for prefixed addi
      https://git.kernel.org/powerpc/c/7e67c73b939b25d4ad18a536e52282aa35d8ee56
[3/4] powerpc/sstep: Introduce macros to retrieve Prefix instruction operands
      https://git.kernel.org/powerpc/c/68a180a44c29d7e918ae7d3c18a01b0751d1c22f
[4/4] powerpc/test_emulate_step: Move extern declaration to sstep.h
      https://git.kernel.org/powerpc/c/e93ad65e3611b06288efdf0cfd76c012df3feec1

cheers

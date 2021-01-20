Return-Path: <SRS0=bcc2=GX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8809C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 04:48:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E89123137
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 04:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E89123137
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLCh12dkyzDqx6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 15:48:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLCc71svrzDqq3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2021 15:44:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DLCc66rmbz9sWF; Wed, 20 Jan 2021 15:44:38 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Sandipan Das <sandipan@linux.ibm.com>
In-Reply-To: <20210118093145.10134-1-sandipan@linux.ibm.com>
References: <20210118093145.10134-1-sandipan@linux.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Fix exit status of pkey tests
Message-Id: <161111785184.3309920.12182707496312103482.b4-ty@ellerman.id.au>
Date: Wed, 20 Jan 2021 15:44:38 +1100 (AEDT)
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
Cc: harish@linux.ibm.com, aneesh.kumar@linux.ibm.com, efuller@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 18 Jan 2021 15:01:45 +0530, Sandipan Das wrote:
> Since main() does not return a value explicitly, the
> return values from FAIL_IF() conditions are ignored
> and the tests can still pass irrespective of failures.
> This makes sure that we always explicitly return the
> correct test exit status.

Applied to powerpc/fixes.

[1/1] selftests/powerpc: Fix exit status of pkey tests
      https://git.kernel.org/powerpc/c/92a5e1fdb286851d5bd0eb966b8d075be27cf5ee

cheers

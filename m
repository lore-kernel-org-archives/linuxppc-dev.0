Return-Path: <SRS0=CqhW=BD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE02C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:12:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D3F206D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D3F206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCt414kdQzF1Jy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 01:12:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCqgj6mQDzDrdN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 23:25:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BCqgg6kMvz9sV9; Fri, 24 Jul 2020 23:25:03 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BCqgf3dNZz9sTh; Fri, 24 Jul 2020 23:24:56 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200722055315.962391-1-mpe@ellerman.id.au>
References: <20200722055315.962391-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Add test of memcmp at end of page
Message-Id: <159559697453.1657499.15006362199310101046.b4-ty@ellerman.id.au>
Date: Fri, 24 Jul 2020 23:24:56 +1000 (AEST)
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

On Wed, 22 Jul 2020 15:53:15 +1000, Michael Ellerman wrote:
> Update our memcmp selftest, to test the case where we're comparing up
> to the end of a page and the subsequent page is not mapped. We have to
> make sure we don't read off the end of the page and cause a fault.
> 
> We had a bug there in the past, fixed in commit
> d9470757398a ("powerpc/64: Fix memcmp reading past the end of src/dest").

Applied to powerpc/next.

[1/1] selftests/powerpc: Add test of memcmp at end of page
      https://git.kernel.org/powerpc/c/8ac9b9d61f0eceba6ce571e7527798465ae9a7c5

cheers

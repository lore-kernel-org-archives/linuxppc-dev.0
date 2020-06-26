Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E065FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 05:01:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904F820768
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 05:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904F820768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tPr00qdFzDqw4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 15:01:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tPTh4JWFzDqlB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 14:46:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49tPTf2zNrz9sTJ; Fri, 26 Jun 2020 14:45:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Jordan Niethe <jniethe5@gmail.com>
In-Reply-To: <20200520021103.19798-1-jniethe5@gmail.com>
References: <20200520021103.19798-1-jniethe5@gmail.com>
Subject: Re: [PATCH 1/2] selftests/powerpc: Allow choice of CI memory location
 in alignment_handler test
Message-Id: <159314672741.1150869.6200686826197857668.b4-ty@ellerman.id.au>
Date: Fri, 26 Jun 2020 14:45:57 +1000 (AEST)
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
Cc: alistair@popple.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 20 May 2020 12:11:02 +1000, Jordan Niethe wrote:
> The alignment handler selftest needs cache-inhibited memory and
> currently /dev/fb0 is relied on to provided this. This prevents running
> the test on systems without /dev/fb0 (e.g., mambo). Read the commandline
> arguments for an optional path to be used instead, as well as an
> optional offset to be for mmaping this path.

Applied to powerpc/next.

[1/2] selftests/powerpc: Allow choice of CI memory location in alignment_handler test
      https://git.kernel.org/powerpc/c/01bd294642841998c76d9e6929597dcb7da9466a
[2/2] selftests/powerpc: Add prefixed loads/stores to alignment_handler test
      https://git.kernel.org/powerpc/c/620a6473df36f8dc6f70bc85ff3465b2e21d1254

cheers

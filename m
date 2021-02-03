Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68F0C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:15:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5C364F9E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5C364F9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW2Gk3zpVzDxW3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 00:15:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09y0b8SzDwvQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:54 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09t1PcCz9tlX; Wed,  3 Feb 2021 22:40:49 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Po-Hsu Lin <po-hsu.lin@canonical.com>
In-Reply-To: <20201228043459.14281-1-po-hsu.lin@canonical.com>
References: <20201228043459.14281-1-po-hsu.lin@canonical.com>
Subject: Re: [PATCH] selftests/powerpc: make the test check in eeh-basic.sh
 posix compliant
Message-Id: <161235199965.1516112.16797710998425289109.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:49 +1100 (AEDT)
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
Cc: shuah@kernel.org, oohall@gmail.com, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 28 Dec 2020 12:34:59 +0800, Po-Hsu Lin wrote:
> The == operand is a bash extension, thus this will fail on Ubuntu with
> 
> As the /bin/sh on Ubuntu is pointed to DASH.
> 
> Use -eq to fix this posix compatibility issue.

Applied to powerpc/next.

[1/1] selftests/powerpc: Make the test check in eeh-basic.sh posix compliant
      https://git.kernel.org/powerpc/c/3db380570af7052620ace20c29e244938610ca71

cheers

Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A268BC433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:10:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049A661456
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049A661456
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQLX206WPz3c8r
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 23:10:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQLVG5Bhlz3034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 23:09:10 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FQLVG0bD4z9vFD; Wed, 21 Apr 2021 23:09:09 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Shuah Khan <shuah@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>
In-Reply-To: <469f37ab91984309eb68c0fb47e8438cdf5b6463.1617198956.git.christophe.leroy@csgroup.eu>
References: <469f37ab91984309eb68c0fb47e8438cdf5b6463.1617198956.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] selftests: timens: Fix gettime_perf to work on powerpc
Message-Id: <161901050320.1961279.8916640678733082942.b4-ty@ellerman.id.au>
Date: Wed, 21 Apr 2021 23:08:23 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 31 Mar 2021 13:59:17 +0000 (UTC), Christophe Leroy wrote:
> On powerpc:
> - VDSO library is named linux-vdso32.so.1 or linux-vdso64.so.1
> - clock_gettime is named __kernel_clock_gettime()
> 
> Ensure gettime_perf tries these names before giving up.

Applied to powerpc/next.

[1/1] selftests: timens: Fix gettime_perf to work on powerpc
      https://git.kernel.org/powerpc/c/f56607e85ee38f2a5bb7096e24e2d40f35d714f9

cheers

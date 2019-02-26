Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8BAC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 01:50:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74BC2184C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 01:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74BC2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447hbw0NPwzDqN5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 12:50:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447hYd3m6kzDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 12:48:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 447hYX0Wmnz9s5c;
 Tue, 26 Feb 2019 12:48:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Souptick Joarder <jrdr.linux@gmail.com>, bamv2005@gmail.com,
 shuah@kernel.org, davem@davemloft.net, benh@kernel.crashing.org,
 paulus@samba.org, adobriyan@gmail.com, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, paulmck@linux.ibm.com, boqun.feng@gmail.com,
 john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
 akpm@linux-foundation.org
Subject: Re: [PATCH] tools: testing: selftests: Remove duplicate headers
In-Reply-To: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
References: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
Date: Tue, 26 Feb 2019 12:48:47 +1100
Message-ID: <87tvgr1fr4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: sabyasachi.linux@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Souptick Joarder <jrdr.linux@gmail.com> writes:
> Remove duplicate headers which are included twice.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
...
>  tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -

I took this hunk via the powerpc tree.

> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> index 167135b..af1b802 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> @@ -11,7 +11,6 @@
>  #include <sys/wait.h>
>  #include <unistd.h>
>  #include <setjmp.h>
> -#include <signal.h>
>  
>  #include "ebb.h"


cheers

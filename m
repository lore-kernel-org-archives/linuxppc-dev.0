Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL5Wp2rnHzDqPD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 22:05:10 +1000 (AEST)
Message-ID: <1464869109.31709.0.camel@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Import Anton's mmap & futex micro
 benchmarks
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: Anton Blanchard <anton@samba.org>
Date: Thu, 02 Jun 2016 22:05:09 +1000
In-Reply-To: <1464868921-30413-1-git-send-email-mpe@ellerman.id.au>
References: <1464868921-30413-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-02 at 22:02 +1000, Michael Ellerman wrote:
> +
> +int test_futex(void)
> +{
> +	struct timespec ts_start, ts_end;
> +        unsigned long i = ITERATIONS;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &ts_start);
> +
> +        while (i--) {
> +                unsigned int addr = 0;
> +                futex(&addr, FUTEX_WAKE, 1, NULL, NULL, 0);
> +        }

Ugh, I can't even ..

Obviously I'll fix up the whitespace before committing.

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402hNZ2vQmzDr3H
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 21:22:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: build warning in drivers/macintosh/rack-meter.c
In-Reply-To: <20180316164614.07f2f573@canb.auug.org.au>
References: <20180316164614.07f2f573@canb.auug.org.au>
Date: Fri, 16 Mar 2018 21:22:33 +1100
Message-ID: <87efkkfhg6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> These warnings have beeen around for a while now;
>
> drivers/macintosh/rack-meter.c:157:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
>   memset(rdma->buf1, 0, ARRAY_SIZE(rdma->buf1));
>   ^~~~~~
> drivers/macintosh/rack-meter.c:158:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
>   memset(rdma->buf2, 0, ARRAY_SIZE(rdma->buf2));
>   ^~~~~~
>
> Introduced by commit
>
>   4f7bef7a9f69 ("drivers: macintosh: rack-meter: fix bogus memsets")

Yep looks like a bug.

Aaro, can you send a patch?

cheers

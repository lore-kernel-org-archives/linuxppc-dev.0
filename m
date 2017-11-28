Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymLS502qvzDrTf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 22:05:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Liu ping fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: what is the state about "[v2] ppc64 boot: Wait for boot cpu to
 show up if nr_cpus limit is about to hit"
In-Reply-To: <CAFgQCTvOGfq2b861rgosCWD3EMNUOd-vVUp2K_sQYcWqeVepcQ@mail.gmail.com>
References: <CAFgQCTvOGfq2b861rgosCWD3EMNUOd-vVUp2K_sQYcWqeVepcQ@mail.gmail.com>
Date: Tue, 28 Nov 2017 22:05:40 +1100
Message-ID: <87h8tezmrf.fsf@concordia.ellerman.id.au>
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

Liu ping fan <kernelfans@gmail.com> writes:

> Hi,
>
> I can not find the history about:
> https://patchwork.ozlabs.org/patch/577193/
>
>
> Can we have this patch?

I strongly dislike it.

Our CPU discovery code is already a big mess, in two separate places,
and this makes it worse.

In theory we have a split between logical and hardware CPU numbers, so
we should just be able to call the whatever CPU we boot on CPU 0. Why
does that not work? And should we fix that?

cheers

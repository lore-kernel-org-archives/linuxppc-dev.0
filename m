Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXrLk0rxMzDqcy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 21:50:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Cyril Bur <cyrilbur@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PowerPC][next-20170324][kselftest] kernel Oops when running
 tm/tm-signal-context-chk-vsx
In-Reply-To: <1495521199.9020.13.camel@abdul.in.ibm.com>
References: <1490612559.8344.15.camel@abdul.in.ibm.com>
 <871sthbu12.fsf@concordia.ellerman.id.au>
 <1491209923.7788.9.camel@abdul.in.ibm.com>
 <1491210231.7788.12.camel@abdul.in.ibm.com>
 <1495521199.9020.13.camel@abdul.in.ibm.com>
Date: Wed, 24 May 2017 21:50:36 +1000
Message-ID: <87mva2a2yb.fsf@concordia.ellerman.id.au>
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

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> Hi Cyril,
>
> I see a similar trace, but with 'tm-signal-stack' test for mainline
> kernel 4.12.0-rc1 on PowerVM LPAR.

I can't reproduce this here.

Can you please retest on rc2.

Also please include the exact version of the test (it prints it), and
what toolchain you built it with.

cheers

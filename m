Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNYqG5Yb8zDqw4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 22:27:06 +1000 (AEST)
Message-ID: <1465216025.2658.7.camel@ellerman.id.au>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 06 Jun 2016 22:27:05 +1000
In-Reply-To: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
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

On Mon, 2016-06-06 at 10:52 +0300, Denis Kirjanov wrote:

> Update: now with the proper mailing address.
> 
> Hi,
> 
> Posting if anyone knows how to quickly fix it :)

Sorry but no.

> Enabling  CONFIG_PPC_EARLY_DEBUG on my quad G5 causes kernel to die
> with the  unrecoverable exception 4100.

That means you took a SLB miss when MSR_RI was off.

What's at c000000000ace328 ?

> I haven't bisected this yet. Photo attached.

A bisect would be awesome.

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAB891A0BEB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 08:26:18 +1100 (AEDT)
Message-ID: <1424381177.22771.1.camel@ellerman.id.au>
Subject: Re: bpf: Enable BPF JIT on ppc32
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Date: Fri, 20 Feb 2015 08:26:17 +1100
In-Reply-To: <CAOJe8K0awkwdYNZr5GdRJFQLCJ0F1GOF730Q3UwT7KBJw0c7Uw@mail.gmail.com>
References: <1424156683-2682-1-git-send-email-kda@linux-powerpc.org>
 <20150219.155613.1219259214030608341.davem@davemloft.net>
 <CAOJe8K0awkwdYNZr5GdRJFQLCJ0F1GOF730Q3UwT7KBJw0c7Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-20 at 01:07 +0400, Denis Kirjanov wrote:
> On 2/19/15, David Miller <davem@davemloft.net> wrote:
> > From: Denis Kirjanov <kda@linux-powerpc.org>
> > Date: Tue, 17 Feb 2015 10:04:37 +0300
> >
> >> This patch series enables BPF JIT on ppc32. There are relatevily
> >> few chnages in the code to make it work.
> >>
> >> All test_bpf tests passed both on 7447a and P2041-based machines.
> >>
> >> Changelog:
> >> v1 - > v2: Reordered Kconfig patch in the series
> >
> > Who plans to take this series?  A PowerPC maintainer?
> >
> > If not, should I take it?
> 
> I think that it should go through your tree...

I'm happy for Dave to take it.

But did you test 64-bit as well?

cheers

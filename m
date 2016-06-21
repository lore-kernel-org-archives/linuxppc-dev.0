Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYlGf1w1rzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 21:04:10 +1000 (AEST)
Message-ID: <1466507043.18876.1.camel@ellerman.id.au>
Subject: Re: [6/6] ppc: ebpf/jit: Implement JIT compiler for extended BPF
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Matt Evans <matt@ozlabs.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@fb.com>, Denis Kirjanov
 <kda@linux-powerpc.org>, Paul Mackerras <paulus@samba.org>, "David S.
 Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>
Date: Tue, 21 Jun 2016 21:04:03 +1000
In-Reply-To: <20160621065847.GD8886@naverao1-tp.localdomain>
References: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <3rWKtT2tSrz9t2G@ozlabs.org>
 <20160619173642.GB8886@naverao1-tp.localdomain>
 <1466465899.437.0.camel@ellerman.id.au>
 <20160621065847.GD8886@naverao1-tp.localdomain>
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

On Tue, 2016-06-21 at 12:28 +0530, Naveen N. Rao wrote:
> On 2016/06/21 09:38AM, Michael Ellerman wrote:
> > On Sun, 2016-06-19 at 23:06 +0530, Naveen N. Rao wrote:
> > > 
> > > #include <asm/kprobes.h>
> > > 
> > > in bpf_jit_comp64.c
> > > 
> > > Can you please check if it resolves the build error?
> > 
> > Can you? :D
> 
> :)
> Sorry, I should have explained myself better. I did actually try your 
> config and I was able to reproduce the build error. After the above 
> #include, that error went away, but I saw some vdso related errors. I 
> thought I was doing something wrong and needed a different setup for 
> that particular kernel config, which is why I requested your help in the 
> matter. I just didn't do a good job of putting across that message...
 
Ah OK. Not sure why you're seeing VDSO errors?

> Note to self: randconfig builds *and* more time drafting emails :)

No stress. You don't need to do randconfig builds, or even build all the
arch/powerpc/ configs, just try to do a reasonable set, something like - ppc64,
powernv, pseries, pmac32, ppc64e.

I'm happy to catch the esoteric build failures.

> Do you want me to respin the patches?

No that's fine, I'll fix it up here.

cheers

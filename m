Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A9BBEB6FEE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 08:11:52 +1000 (EST)
Message-ID: <1333491102.3040.12.camel@pasglop>
Subject: Re: [REGRESSION][PATCH V4 3/3] bpf jit: Let the powerpc jit handle
 negative offsets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Wed, 04 Apr 2012 08:11:42 +1000
In-Reply-To: <20120403.180302.342779808900865443.davem@davemloft.net>
References: <4F75CA89.4010709@googlemail.com> <4F75D2A5.7060407@googlemail.com>
 <20120403.180302.342779808900865443.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kaffeemonster@googlemail.com, eric.dumazet@gmail.com, matt@ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-03 at 18:03 -0400, David Miller wrote:

> > Signed-off-by: Jan Seiffert <kaffeemonster@googlemail.com>
> > 
> > I have only compile tested this, -ENOHARDWARE.
> > Can someone with more powerpc kung-fu review and maybe test this?
> > Esp. powerpc asm is not my strong point. I think i botched the
> > stack frame in the call setup. Help?
> 
> I'm not applying this until a powerpc person tests it.
> 
> Also, we have an ARM JIT in the tree which probably needs to
> be fixed similarly.

Matt's having a look at powerpc

Cheers,
Ben.

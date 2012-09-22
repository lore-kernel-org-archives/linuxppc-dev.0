Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 893992C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 07:21:10 +1000 (EST)
Message-ID: <1348348807.1132.76.camel@pasglop>
Subject: Re: linux-next: build failure after merge of the final tree
 (net-next tree related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Sun, 23 Sep 2012 07:20:07 +1000
In-Reply-To: <20120922.160027.1528491047223302539.davem@davemloft.net>
References: <1348179764.1132.35.camel@pasglop>
 <20120920.185315.576326460331670020.davem@davemloft.net>
 <1348264000.1132.63.camel@pasglop>
 <20120922.160027.1528491047223302539.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, mika.westerberg@linux.intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-09-22 at 16:00 -0400, David Miller wrote:
> 
> I think I'm going to just end up restricting this driver to X86
> as was originally suggested.

Probably the easiest fix indeed.

> There seems to be no real consistent Kconfig protection for users
> of isa_virt_to_bus() and friends.
> 
> We know that ISA_DMA_API doesn't do it, and ISA doesn't do it either
> as powerpc also allows that to bet set for CHRP and friends.

It's a old mess :-( And not an easy one to untangle...

Cheers,
Ben.

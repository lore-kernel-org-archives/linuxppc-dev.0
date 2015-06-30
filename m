Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA9FA1A0927
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 08:18:12 +1000 (AEST)
Message-ID: <1435702685.24693.3.camel@ellerman.id.au>
Subject: Re: [PATCH RESEND] Update kernel math-emu code from current glibc
 soft-fp
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joseph Myers <joseph@codesourcery.com>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, "David S.Miller"
 <davem@davemloft.net>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Date: Wed, 01 Jul 2015 08:18:05 +1000
In-Reply-To: <alpine.DEB.2.10.1506301042250.2339@digraph.polyomino.org.uk>
References: <alpine.DEB.2.10.1505192206580.28384@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1506221321340.27145@digraph.polyomino.org.uk>
 <1435634913.24866.1.camel@ellerman.id.au>
 <alpine.DEB.2.10.1506301042250.2339@digraph.polyomino.org.uk>
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

On Tue, 2015-06-30 at 10:48 +0000, Joseph Myers wrote:
> On Tue, 30 Jun 2015, Michael Ellerman wrote:
> 
> > Is there some way you can imagine of splitting this up into smaller chunks, so
> > that different arches can merge the pieces separately?
> 
> Well, it could be split as:
> 
> 1. Rename include/math-emu to math-emu-old and update architectures for 
> the renaming (mechanically).
> 
> 2. Add new include/math-emu.
> 
> 3,4,5,6,7. Move each architecture from math-emu-old to math-emu.
> 
> 8. Remove math-emu-old.
> 
> You still have patch 1 affecting all five architectures, but with the 
> per-architecture changes being much simpler.

OK. That's obviously a bit more churn, but I think it's probably the best
approach. Unless someone else has a better idea?

cheers

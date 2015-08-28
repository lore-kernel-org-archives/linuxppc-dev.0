Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FE301A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 13:38:35 +1000 (AEST)
Message-ID: <1440733115.8076.6.camel@ellerman.id.au>
Subject: Re: Ping Re: [PATCH 0/8] math-emu: Update kernel math-emu code from
 current glibc soft-fp
From: Michael Ellerman <mpe@ellerman.id.au>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, "David	S.Miller"
 <davem@davemloft.net>
Cc: Joseph Myers <joseph@codesourcery.com>, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Date: Fri, 28 Aug 2015 13:38:35 +1000
In-Reply-To: <20150827133102.77026410@mschwide>
References: <alpine.DEB.2.10.1507021542380.29415@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1508191433380.11312@digraph.polyomino.org.uk>
 <1440026806.13406.2.camel@ellerman.id.au>
 <alpine.DEB.2.10.1508261442440.13146@digraph.polyomino.org.uk>
 <1440645125.23182.11.camel@ellerman.id.au>
 <20150827133102.77026410@mschwide>
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

On Thu, 2015-08-27 at 13:31 +0200, Martin Schwidefsky wrote:
> On Thu, 27 Aug 2015 13:12:05 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Wed, 2015-08-26 at 14:44 +0000, Joseph Myers wrote:
> > > On Thu, 20 Aug 2015, Michael Ellerman wrote:
> > > > I'm reluctant to proceed with merging them though until we've heard at least
> > > > *something* from the other maintainers.
> > > 
> > > Ping again for the other-architecture maintainers (alpha, s390, sh, 
> > > sparc)....
> > 
> > OK I've put this whole series in a branch with the acks we have so far.
> > 
> > I'll ask Stephen to put it in linux-next once 4.3-rc1 is out, and I'll ask
> > Linus to pull it for 4.4
> > 
> > I haven't published the branch yet, so if the s390 and sparc maintainers want
> > to send me acks I'll rebase and add them.
> 
> For the s390 parts:
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Thanks.

So we're just waiting on davem for an ack for arch/sparc :D

cheers

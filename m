Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C2543DDE2C
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 08:19:16 +1100 (EST)
Date: Fri, 30 Nov 2007 15:22:43 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI, PCI-X and PCI-Express support
	among others
Message-ID: <20071130212243.GA9483@lixom.net>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130141540.GA3117@lixom.net>
	<1196456043.13230.96.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196456043.13230.96.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 01, 2007 at 07:54:03AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Fri, 2007-11-30 at 08:15 -0600, Olof Johansson wrote:
> > On Fri, Nov 30, 2007 at 05:10:38PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > There will be further cleanups and fixes before 2.6.25 opens
> > 
> > May I suggest running them through checkpatch.pl? It finds stuff in over
> > half of the ones I tried it on :)
> 
> and I don't give a shit about checkpatch.pl

That's up to you, but I've found that it saves a handful of nitpicky
comments about whitespace, etc, after posting. It doesn't mean every
single warning from it has to be followed.

Since you said you'd post this series again I figured it could be useful
to fix the whitespace it finds, instead of having people find it by hand
when reading the patches.

That's all.


-Olof

Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id E17A6B7D27
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 19:19:43 +1000 (EST)
Date: Mon, 10 May 2010 18:19:40 +0900
From: Simon Horman <horms@verge.net.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec-tools, ppc64: Fix segfault on parsing of large
	device trees.
Message-ID: <20100510091940.GA16856@verge.net.au>
References: <4BE78E06.6080601@ozlabs.org>
 <31392.1273467303@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <31392.1273467303@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 10, 2010 at 02:55:03PM +1000, Michael Neuling wrote:
> 
> 
> In message <4BE78E06.6080601@ozlabs.org> you wrote:
> > 
> > ppc64's fs2dt used to use a fixed-size array into which the device tree
> > was parsed.  There was no bounds checking, so with a large device tree other
> > heap data ended up getting stomped -- SIGSEGV time.
> > 
> > This patch adds a function, 'dt_reserve', to check whether there's enough spa
> ce
> > left prior to writing data to the array.  If not, the array is realloced.
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> 
> FWIW...
> 
> Ack-by: Michael Neuling <mikey@neuling.org>
> 
> (also added linuxppc-dev@ozlabs.org to CC list)

Thanks, applied.

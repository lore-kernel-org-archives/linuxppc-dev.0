Return-Path: <kyle@fattire.cabal.ca>
Received: from stout.engsoc.carleton.ca (stout.engsoc.carleton.ca
	[134.117.69.22]) by ozlabs.org (Postfix) with ESMTP id 1CAF7DE047
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 12:21:46 +1000 (EST)
Date: Thu, 11 Oct 2007 22:04:19 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] powerpc: Switch to generic WARN_ON()/BUG_ON()
Message-ID: <20071012020419.GB19268@fattire.cabal.ca>
References: <20071011171211.GB10877@lixom.net>
	<20071011171413.GC10877@lixom.net>
	<18190.52379.97647.468384@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18190.52379.97647.468384@cargo.ozlabs.ibm.com>
Cc: grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, Olof Johansson <olof@lixom.net>,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 12, 2007 at 11:23:39AM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Not using the ppc-specific WARN_ON/BUG_ON constructs actually saves about
> > 4K text on a ppc64_defconfig. The main reason seems to be that prepping
> > the arguments to the conditional trap instructions is more work than
> > just doing a compare and branch.
> 
> It might be more instructions but it takes fewer cycles, I would
> expect.  Do you have the actual instruction sequences to compare?
> 

I really hope WARN_ON/BUG_ON aren't hotpaths on powerpc. ;-)

Cheers,
	Kyle

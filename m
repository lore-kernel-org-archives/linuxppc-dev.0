Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81C3667AC7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 02:11:20 +1000 (EST)
Date: Fri, 6 May 2005 08:39:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jason McMullan <jason.mcmullan@timesys.com>
Message-ID: <20050506113935.GA5962@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1115384665.9050.22.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1115384665.9050.22.camel@jmcmullan.timesys>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 06, 2005 at 09:04:24AM -0400, Jason McMullan wrote:
> On Thu, 2005-05-05 at 14:20 -0300, Marcelo Tosatti wrote:
> > [snip snip]
> >
> > Allocateing from the coherent memory DMA region. Which sits at, I suppose, 
> > after initial 8Megs in all configurations (should be always). 
> >
> 
> 
>   What if your board (ie the MPC885ADS) only has 8Mb? Soldered on.

Jason,

Oops, in that case you can't pin the 8Mbyte entry. 

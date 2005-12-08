Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEF43688C6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 01:31:58 +1100 (EST)
Date: Thu, 8 Dec 2005 12:31:49 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20051208143149.GA14554@dmt.cnet>
References: <20051206164212.82779.qmail@web33505.mail.mud.yahoo.com>
	<20051206211459.E8976353F54@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051206211459.E8976353F54@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Denx vs kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Dec 06, 2005 at 10:14:59PM +0100, Wolfgang Denk wrote:
> In message <20051206164212.82779.qmail@web33505.mail.mud.yahoo.com> you wrote:
> > I'm looking at embedding linux into a PowerPC-based
> > system.  I found the DENX website to be very helpful,
> > but I'm struggling to understand a few items:
> 
> It would be helpful if you precisely stated which of the  misc  trees
> you are talking about.
> 
> > 1) The source from kernel.org appears to have support
> > for the powerpc (arch/powerpc/8xx_io).  But when using
> > 'make xconfig' I cannot select PowerPC from the list
> > of processors.  Is this just a limitation on the the
> > configuration utility?
> 
> Seems like you are trying to use the linux-2.6-denx tree  and  forgot
> to  pass  a "ARCH=ppc" argument to "make" (and did not set "ARCH=ppc"
> in your shell environment either).
> 
> > 2) What is the difference between the sources on DENX
> > and kernel.org?  Are there other places where PPC
> 
> We have some stuff added which was submitted as patches to  the  list
> but  not  all  of  this  has  been  accepted  for  or merged into the
> kernel.org tree yet.

Hi Wolfgang,

Is there a list of your fixes anywhere? Is the linux-2.6-denx tree
public?

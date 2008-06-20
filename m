Return-Path: <billfink@mindspring.com>
Received: from elasmtp-mealy.atl.sa.earthlink.net
	(elasmtp-mealy.atl.sa.earthlink.net [209.86.89.69])
	by ozlabs.org (Postfix) with ESMTP id 430FCDE6E8
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 03:50:16 +1000 (EST)
Date: Fri, 20 Jun 2008 13:50:13 -0400
From: Bill Fink <billfink@mindspring.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] fs_enet: restore promiscuous and multicast settings in
	restart()
Message-Id: <20080620135013.36fbafa7.billfink@mindspring.com>
In-Reply-To: <200806201025.28768.laurentp@cse-semaphore.com>
References: <200806181707.17739.laurentp@cse-semaphore.com>
	<20080619230128.def96ee0.billfink@mindspring.com>
	<200806201025.28768.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Jun 2008, Laurent Pinchart wrote:

> On Friday 20 June 2008 05:01, Bill Fink wrote:
> > On Wed, 18 Jun 2008, Laurent Pinchart wrote:
> > 
> > > The restart() function is called when the link state changes and resets
> > > multicast and promiscous settings. This patch restores those settings at 
> the
> > > end of restart().
> > > 
> > > Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> > > ---
> > >  drivers/net/fs_enet/mac-fcc.c     |    3 +++
> > >  2 files changed, 4 insertions(+), 1 deletions(-)
> > 
> > Is the whole patch here?  The above says 2 files changed and 5 lines
> > changed, but what's included here is only 1 file and 3 line changes.
> 
> Yes it is. I've hand-removed a completely unrelated change that I had 
> committed to my git tree in the same go (back when I wasn't very familiar 
> with git). Do I need to resubmit ?

I can't answer that.  I just wanted to make sure part of the patch
wasn't accidentally left out.

						-Bill

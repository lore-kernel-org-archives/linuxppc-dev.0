Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 6FF6A2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 08:41:30 +1000 (EST)
Date: Thu, 14 Oct 2004 15:41:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041014224128.GE19791@smtp.west.cox.net>
References: <BCEFJBPJCGFCNMMMIDBHMEIKCIAA.Joakim.Tjernlund@lumentis.se>
	<Pine.LNX.4.60.0410141824300.24365@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410141824300.24365@localhost.localdomain>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 14, 2004 at 06:25:54PM -0400, Robert P. J. Day wrote:
> On Fri, 15 Oct 2004, Joakim Tjernlund wrote:
> 
> > > On Thu, Oct 14, 2004 at 04:53:49PM +0200, Joakim Tjernlund wrote:
> > >
> > > > Is it not time to merge 8xx from linuxppc-2.5 into Linus tree?
> > > >
> > > > I know the 8xx is not fully functional yet but this isn't done
> > > > soon I think it won't happen at all. The 8xx arch can be made to
> > > > depend on BROKEN in Linus tree to make it clear that it isn't
> > > > working properly yet.
> > >
> > > I've been the hard-ass about holding back on moving 8xx forward.  Once
> > > 2.6.9 finally comes out (assuming and hoping that Linus really intends
> > > to do a release and not -rc5), I'll start moving stuff over and make it
> > > depend on BROKEN hopefully in time for 2.6.10-rc1.
> >
> > This is great news, thanks.
> 
> what does this mean in terms of urgency in getting changes into the
> 8xx stuff, then?  does this imply a fixed window of opportunity in the
> near future, or does it mean that once stuff starts to get moved
> upstream, it will get moved on a regular basis?  just curious.

Once upstream, new changes won't (unless not-fully-baked) go into
linuxppc-2.5.

-- 
Tom Rini
http://gate.crashing.org/~trini/

Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id EF6F12BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Oct 2004 08:22:46 +1000 (EST)
Date: Fri, 22 Oct 2004 15:22:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
Message-ID: <20041022152244.F28106@home.com>
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022013320.GB22069@gate.ebshome.net>
	<20041022103859.50e2b2f6.Hiroshi_DOYU@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041022103859.50e2b2f6.Hiroshi_DOYU@montavista.co.jp>;
	from Hiroshi_DOYU@montavista.co.jp on Fri, Oct 22, 2004 at
	10:38:59AM +0900
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 22, 2004 at 10:38:59AM +0900, Hiroshi DOYU wrote:
> On Thu, 21 Oct 2004 18:33:20 -0700
> Eugene Surovegin <ebs@ebshome.net> wrote:
> 
> > On Fri, Oct 22, 2004 at 08:57:33AM +0900, Hiroshi DOYU wrote:
> > > Now I am strugging with booting vanilla(2.4.2x) on ibm440gx and
> > > I could succeed to boot it but, after nfs mounted, it's behavior 
> > > seems too slow. I guess, it looks like the system is running 
> > > half duplex. 
> > 
> > Yeah, driver thinks it's connected to 10Mb hub. How the board is 
> > actualy connected to the network?
> 
> 10Mb hub.

Well, I'm seeing awful half duplex performance on a 10/100Mbps hub
that has negotiated 100Mbps...this is on one hub at home.  At the
office, with a different hub, I seem not to have the problems.  I
will try a 10Mbps hub next.

This is on 440GX EMAC0 w/ current BK 2.6.

-Matt

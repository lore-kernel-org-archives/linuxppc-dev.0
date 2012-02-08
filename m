Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 25110B6FA4
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2012 22:39:55 +1100 (EST)
In-Reply-To: <20120208094426.GC1379@1wt.eu>
References: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <OF6B6562C0.926C4B3C-ONC1257963.005F34B1-C1257963.005F34B2@transmode.se>
 <20111211173346.GC9019@1wt.eu>
 <OF173F1835.8171C985-ONC125799E.002FE8C7-C125799E.0030008A@transmode.se>
 <20120208094426.GC1379@1wt.eu>
Subject: Re: [PATCH 00/14] Backport 8xx TLB to 2.4
To: Willy Tarreau <w@1wt.eu>
Message-ID: <OFE7D02EF5.C8AA7552-ONC125799E.0037BB62-C125799E.0040126D@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 8 Feb 2012 12:39:50 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Dan Malek <ppc6dev@digitaldans.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Willy Tarreau <w@1wt.eu> wrote on 2012/02/08 10:44:26:
>
> Hi Joakim,
>
> On Wed, Feb 08, 2012 at 09:44:18AM +0100, Joakim Tjernlund wrote:
> > Willy Tarreau <w@1wt.eu> wrote on 2011/12/11 18:33:46:
> > >
> > > Hi Joakim,
> > >
> > > On Sun, Dec 11, 2011 at 06:19:54PM +0100, Joakim Tjernlund wrote:
> > > > > To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > > > > From: Willy Tarreau <w@1wt.eu>
> > > > >
> > > > > Hi Joakim,  On Mon, Oct 10, 2011 at 01:30:06PM +0200, Joakim Tjernlund wrote: > This is a
> > > > > backport from 2.6 which I did to overcome 8xx CPU > bugs. 8xx does not update the DAR register
> > > > > when taking a TLB > error caused by dcbX and icbi insns which makes it very > tricky to use these
> > > > > insns. Also the dcbst wrongly sets the > the store bit when faulting into DTLB error. > A few
> > > > > more bugs very found during development. >  > I know 2.4 is in strict maintenance mode and 8xx is
> > > > > obsolete > but as it is still in use I wanted 8xx to age with grace.  Thank you. I must admit I
> > > > > was hoping those patches would come in for a last release before the end of the year :-)  Unless
> > > > > there is any objection from anyone, I'll merge them when kernel.org is back online.  Cheers,
> > > > > Willy
> > > >
> > > > Did this go anywhere?
> > >
> > > Not yet, I just need to find some time to release another 2.4 with these
> > > patches.
> >
> > Ping? There should be a tree somewhere by now :)
>
> I'm planning on doing 2.4.37.12 once I'm finished with 2.6.27.60. However I'll
> have to find another place to host it, as the 2.4 tree was never completely
> recovered from master.kernel.org after the break-in, and admins there have
> many more important things to do than to spend their time restoring the 2.4
> files. Probably that I'll put that into my account.

I see.

>
> BTW, since you're asking, you seem to still be using 2.4. Do you think it's
> worth pursuing maintenance over 2.4.37.12 and if so for how long ? I'm asking
> because until the break-in, I felt like almost nobody was using it anymore,
> but since the break-in, I received a number of mails asking where to download
> it. So now I assume that there are still users, but they're too much silent.

yes, they are silent I guess. I figure, after 2.4.37.12, a public git tree
on kernel org which still receives fixes would be enough.

 Jocke

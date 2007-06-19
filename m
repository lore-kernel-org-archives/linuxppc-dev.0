Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51CE4DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 09:04:41 +1000 (EST)
Date: Tue, 19 Jun 2007 18:04:32 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] rheap: eliminates internal fragments caused by alignment
In-Reply-To: <1182269845.2969.117.camel@gentoo-jocke.transmode.se>
Message-ID: <Pine.LNX.4.64.0706191804100.27810@gate.crashing.org>
References: <46766C91.6090903@freescale.com>
	<1182167304.2969.8.camel@gentoo-jocke.transmode.se>
	<1182269845.2969.117.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Paul <paulus@samba.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 19 Jun 2007, Joakim Tjernlund wrote:

> On Mon, 2007-06-18 at 13:48 +0200, Joakim Tjernlund wrote:
> > On Mon, 2007-06-18 at 19:29 +0800, Li Yang wrote:
> > > The patch adds fragments caused by rh_alloc_align() back to free list, instead
> > > of allocating the whole chunk of memory.  This will greatly improve memory
> > > utilization managed by rheap.
> > >
> > > It solves MURAM not enough problem with 3 UCCs enabled on MPC8323.
> > >
> > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > ---
> >
> > For what it is worth:
> > I have tested this patch and it solves the problem with 3 UCCs
> > as ethernet for me. This fixes a regression introduced after 2.6.20
> > Please consider for 2.6.22
> > Acked-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
>
> I noticed Paulus pull request to Linus and this patch wasn't
> included. I really want to see it included.
>

I'll push (or request pull) from Linus tonight for this to go into 2.6.22

- k

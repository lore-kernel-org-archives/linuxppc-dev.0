Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 947D8DE16F
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 03:38:06 +1100 (EST)
Date: Fri, 7 Mar 2008 10:37:47 -0600
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 6/9] fs_enet: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
Message-ID: <20080307163747.GF10545@ld0162-tx32.am.freescale.net>
References: <20070920220121.GF28784@loki.buserror.net>
	<200802151350.20627.laurentp@cse-semaphore.com>
	<1203089936.20350.7.camel@p60365-ste>
	<200803071623.42519.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803071623.42519.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 04:23:39PM +0100, Laurent Pinchart wrote:
> Hi Sergej,
> 
> On Friday 15 February 2008 16:38, Sergej Stepanov wrote:
> > Am Freitag, den 15.02.2008, 13:50 +0100 schrieb Laurent Pinchart:
> > > We're loosing the possibility of having MDC and MDIO on different ports.
> > > This is quite easy to fix for the non-CONFIG_PPC_CPM_NEW_BINDING case but
> > > I'm not familiar with OF bindings (yet) to fix the
> > > CONFIG_PPC_CPM_NEW_BINDING case.
> >
> > for OF issue i had this for a paar month:
> > http://www.spinics.net/lists/netdev/msg45778.html
> > http://www.spinics.net/lists/netdev/msg47159.html
> > i'll be glad if it helps...
> 
> Could these be applied ? Any showstopper ?

Acked-by: Scott Wood <scottwood@freescale.com>, if I haven't already.

-Scott

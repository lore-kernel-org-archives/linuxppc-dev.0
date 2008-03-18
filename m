Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DEA84DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 14:57:00 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2I3utwR010971
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 23:56:55 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2I3utpQ249054
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 23:56:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2I3uscS019128
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 23:56:55 -0400
Date: Mon, 17 Mar 2008 22:56:06 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
Message-ID: <20080317225606.79f77502@zod.rchland.ibm.com>
In-Reply-To: <1205808100.26869.204.camel@pasglop>
References: <1205488348-22536-1-git-send-email-sr@denx.de>
	<47DE5F43.80604@garzik.org> <1205789101.26869.181.camel@pasglop>
	<1205789205.26869.184.camel@pasglop>
	<20080317164341.12075616@zod.rchland.ibm.com>
	<1205790747.26869.187.camel@pasglop> <47DEF159.3020504@garzik.org>
	<20080317200855.2954971a@zod.rchland.ibm.com>
	<1205808100.26869.204.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Mar 2008 13:41:40 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > http://marc.info/?l=linux-netdev&m=120449748701492&w=2
> > 
> > I sent it to Ben with netdev on CC because you asked the various people
> > sending NEWEMAC patches to you to find a single person.
> > 
> > So from now on, what are we going to do?  It seems we're playing net
> > maintainer russian roulette for NEWEMAC and it's getting old.
> 
> I'm happy to collect the patches. I said I would do it, I was just taken
> aback a bit by Jeff suddenly merging two of Stefan patches directly :-)
> 
> I was actually planning this week to post a serie of all the pending
> EMAC patches for final review.

Ok.  Either way, if it helps someone I'd be happy to roll them into a
newemac branch in my git tree.

josh

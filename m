Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33C6ADDF9C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 08:44:34 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2HLhJQT011961
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 17:43:19 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2HLiRkU127222
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 15:44:27 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2HLiQ0s004555
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 15:44:27 -0600
Date: Mon, 17 Mar 2008 16:43:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
Message-ID: <20080317164341.12075616@zod.rchland.ibm.com>
In-Reply-To: <1205789205.26869.184.camel@pasglop>
References: <1205488348-22536-1-git-send-email-sr@denx.de>
	<47DE5F43.80604@garzik.org> <1205789101.26869.181.camel@pasglop>
	<1205789205.26869.184.camel@pasglop>
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

On Tue, 18 Mar 2008 08:26:45 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Tue, 2008-03-18 at 08:25 +1100, Benjamin Herrenschmidt wrote:
> > > > 
> > > > Signed-off-by: Pravin M. Bathija <pbathija@amcc.com>
> > > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > > ---
> > > >  drivers/net/ibm_newemac/core.c |    7 +++++++
> > > >  1 files changed, 7 insertions(+), 0 deletions(-)
> > > 
> > > applied
> > 
> > Thanks. There's also a couple of patches from Valentine that should go
> > in. I'll ask him to resend to you.
> 
> Actually, they need some arch bits so they are better off going through
> Josh tree on top of the said changes.

There's also the section mismatch patch I sent you.  I don't care who's
tree they go through, but I'd need to know either way so keep me in the
loop please.

josh

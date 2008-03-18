Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CEB0DDF3E
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 12:09:48 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2I18bbP025355
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 21:08:37 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2I19iFY175620
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 19:09:45 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2I19ho9018769
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 19:09:44 -0600
Date: Mon, 17 Mar 2008 20:08:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
Message-ID: <20080317200855.2954971a@zod.rchland.ibm.com>
In-Reply-To: <47DEF159.3020504@garzik.org>
References: <1205488348-22536-1-git-send-email-sr@denx.de>
	<47DE5F43.80604@garzik.org> <1205789101.26869.181.camel@pasglop>
	<1205789205.26869.184.camel@pasglop>
	<20080317164341.12075616@zod.rchland.ibm.com>
	<1205790747.26869.187.camel@pasglop> <47DEF159.3020504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Mar 2008 18:31:53 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Benjamin Herrenschmidt wrote:
> >> There's also the section mismatch patch I sent you.  I don't care who's
> >> tree they go through, but I'd need to know either way so keep me in the
> >> loop please.
> > 
> > Jeff, do you mind if we get those patches through the powerpc tree ?
> > EMAC is very powerpc specific and these are mostly internal driver
> > cuisine.
> 
> Fine with me in concept, though I haven't seen the patches in question.

http://marc.info/?l=linux-netdev&m=120449748701492&w=2

I sent it to Ben with netdev on CC because you asked the various people
sending NEWEMAC patches to you to find a single person.

So from now on, what are we going to do?  It seems we're playing net
maintainer russian roulette for NEWEMAC and it's getting old.

josh

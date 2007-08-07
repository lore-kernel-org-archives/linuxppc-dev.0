Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2F30DDE16
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 23:10:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l77DAo6S029997
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 09:10:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l77DAeiQ199150
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 07:10:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l77DAdsB009631
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 07:10:39 -0600
Date: Tue, 7 Aug 2007 08:10:38 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [patch 04/10] 4xx bootwrapper reworks
Message-ID: <20070807081038.06925ccb@weaponx.rchland.ibm.com>
In-Reply-To: <20070807030547.GC15619@localhost.localdomain>
References: <20070803160900.069522000@linux.vnet.ibm.com>
	<20070803161710.676644000@linux.vnet.ibm.com>
	<20070806043855.GF6103@localhost.localdomain>
	<20070806123602.GZ3925@crusty.rchland.ibm.com>
	<20070807030547.GC15619@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 7 Aug 2007 13:05:47 +1000
David Gibson <dwg@au1.ibm.com> wrote:

> > > Rather than just removing these defines and using hardcoded values,
> > > I'd prefer to see separate SPRN_DBCR0_40X and SPRN_DBCR0_44X defines.
> > 
> > Ok.  And place them where?  In the same file since they aren't DCR defines?
> > Seems fairly trivial, but ok.
> 
> Just where the old 44x specific define was. And yes, it is fairly
> trivial.

Fixed.

> > > [snip]
> > > > +#define EMAC_RESET 0x20000000
> > > > +#define MAL_RESET 0x80000000
> > > 
> > > I think the MAL_RESET definition should go in the same place as the
> > > DCR number definition.
> > 
> > Ok.  Trivial.
> 
> Yes.

Fixed.

> > > As I think I said before, I'm not really happy with this being
> > > hardcoded assuming exactly 2 ethernets.
> > 
> > Well, it's hardcoded to assume one or two.  I know of only one board that has
> > more than two EMACs.  I was hoping we could get this in for 2.6.24 as-is and
> > change it when needs be.  But I'll look at making it var-args or similar.

I'm going to hold off on this for now.  I'm not disagreeing with you,
but there are no upcoming board ports that have more than two EMACs so
I'd like to focus on getting Bamboo (440EP) and Sequoia (440EPx)
in-tree first.  Perhaps even Walnut, if there's time.

josh

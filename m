Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2756DDE33
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 12:11:38 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l782DhYn3829910
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:13:43 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l782DAcg094872
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:13:10 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7829aqS009769
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:09:37 +1000
Date: Wed, 8 Aug 2007 11:19:22 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 04/10] 4xx bootwrapper reworks
Message-ID: <20070808011922.GB20565@localhost.localdomain>
References: <20070803160900.069522000@linux.vnet.ibm.com>
	<20070803161710.676644000@linux.vnet.ibm.com>
	<20070806043855.GF6103@localhost.localdomain>
	<20070806123602.GZ3925@crusty.rchland.ibm.com>
	<20070807030547.GC15619@localhost.localdomain>
	<20070807081038.06925ccb@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070807081038.06925ccb@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2007 at 08:10:38AM -0500, Josh Boyer wrote:
> On Tue, 7 Aug 2007 13:05:47 +1000
> David Gibson <dwg@au1.ibm.com> wrote:
> 
> > > > Rather than just removing these defines and using hardcoded values,
> > > > I'd prefer to see separate SPRN_DBCR0_40X and SPRN_DBCR0_44X defines.
> > > 
> > > Ok.  And place them where?  In the same file since they aren't DCR defines?
> > > Seems fairly trivial, but ok.
> > 
> > Just where the old 44x specific define was. And yes, it is fairly
> > trivial.
> 
> Fixed.
> 
> > > > [snip]
> > > > > +#define EMAC_RESET 0x20000000
> > > > > +#define MAL_RESET 0x80000000
> > > > 
> > > > I think the MAL_RESET definition should go in the same place as the
> > > > DCR number definition.
> > > 
> > > Ok.  Trivial.
> > 
> > Yes.
> 
> Fixed.
> 
> > > > As I think I said before, I'm not really happy with this being
> > > > hardcoded assuming exactly 2 ethernets.
> > > 
> > > Well, it's hardcoded to assume one or two.  I know of only one board that has
> > > more than two EMACs.  I was hoping we could get this in for 2.6.24 as-is and
> > > change it when needs be.  But I'll look at making it var-args or similar.
> 
> I'm going to hold off on this for now.  I'm not disagreeing with you,
> but there are no upcoming board ports that have more than two EMACs so
> I'd like to focus on getting Bamboo (440EP) and Sequoia (440EPx)
> in-tree first.  Perhaps even Walnut, if there's time.

Fair enough.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

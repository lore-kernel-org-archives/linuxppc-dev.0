Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D44E8DDD06
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 04:00:45 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4OI0fDS015539
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 14:00:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4OI0fVT531758
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 14:00:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4OI0fKd001285
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 14:00:41 -0400
Date: Thu, 24 May 2007 13:00:40 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/4] powerpc: remove dead EEH code.
Message-ID: <20070524180039.GL5921@austin.ibm.com>
References: <20070523171328.GY5921@austin.ibm.com>
	<20070523172338.GC32380@austin.ibm.com>
	<20070524095327.75e239b2.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070524095327.75e239b2.sfr@canb.auug.org.au>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 24, 2007 at 09:53:27AM +1000, Stephen Rothwell wrote:
> On Wed, 23 May 2007 12:23:38 -0500 linas@austin.ibm.com (Linas Vepstas) wrote:
> >
> > @@ -1221,11 +1220,10 @@ static int proc_eeh_show(struct seq_file
> >  				"check not wanted=%ld\n"
> >  				"eeh_total_mmio_ffs=%ld\n"
> >  				"eeh_false_positives=%ld\n"
> > -				"eeh_ignored_failures=%ld\n"
> >  				"eeh_slot_resets=%ld\n",
> >  				no_device, no_dn, no_cfg_addr,
> >  				ignored_check, total_mmio_ffs,
> > -				false_positives, ignored_failures,
> > +				false_positives,
> >  				slot_resets);
> 
> This changes a user visible interface - are we sure noone uses it?
> (I suspect it is fine because of the format, but just asking anyway.)

The only user I know of is a "how to test eeh" document that has
a snapshot of this.  For the most part, EEH has been very
out-of-the-limelight.

--linas

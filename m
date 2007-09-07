Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86A59DDF74
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 11:15:57 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l871FvUP021864
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 11:15:57 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l871JUTk207978
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 11:19:30 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l871FuEN025670
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 11:15:56 +1000
Date: Fri, 7 Sep 2007 11:06:17 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 2/6] cuimage for Bamboo board
Message-ID: <20070907010617.GM26079@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.029244000@linux.vnet.ibm.com>
	<20070903010111.GC31499@localhost.localdomain>
	<1188826931.3772.11.camel@localhost.localdomain>
	<20070905011045.GC17189@localhost.localdomain>
	<1188952819.3223.5.camel@localhost.localdomain>
	<20070905054645.GA26788@localhost.localdomain>
	<1188971635.3223.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1188971635.3223.9.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 12:53:54AM -0500, Josh Boyer wrote:
> On Wed, 2007-09-05 at 15:46 +1000, David Gibson wrote:
> > > > > > There must surely be a way to get the MAC addresses out of OpenBIOS...
> > > > > 
> > > > > Probably.  I just need to find out where they are stored.
> > > > 
> > > > It's not buried somewhere in the arch/ppc/boot code?
> > > 
> > > It's not OpenBIOS, it's PIBS.  And the arch/ppc port uses __res, which
> > > I'd rather avoid.  But I did find where it's stored in flash, so I can
> > > read it from there.  I just need to do a little more work to get it in a
> > > manner that can be used.
> > 
> > Hrm.. is that address actually guaranteed to be stable across PIBS
> > versions?  If arch/ppc uses __res, I think we should do that too.  It
> > shouldn't be any worse than what we already do fot cuboot.
> 
> The address should be stable for all versions of PIBS that come on the
> Bamboo boards, yes.  And after looking at it a bit more, the wrapper in
> arch/ppc for PIBS essentially mocks up __res by reading the values out
> of flash.  So the way I'm doing it is the way it was already done.

Ah, ok.  Fine then.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

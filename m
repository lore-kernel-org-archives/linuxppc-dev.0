Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B4D2DDEB8
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 13:15:11 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m242Eqta017589
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 13:14:52 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m242ImR1133974
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 13:18:48 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m242F8Ga015008
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 13:15:08 +1100
Date: Tue, 4 Mar 2008 13:15:03 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Bamboo PCI interrupt issues
Message-ID: <20080304021503.GH1393@localhost.localdomain>
References: <1204588953.7921.13.camel@basalt>
	<20080304005922.GB1393@localhost.localdomain>
	<1204594967.21545.46.camel@pasglop>
	<20080304015329.GE1393@localhost.localdomain>
	<08b18695c383fb829ecf3ab6c2822bd1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08b18695c383fb829ecf3ab6c2822bd1@kernel.crashing.org>
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2008 at 03:07:50AM +0100, Segher Boessenkool wrote:
> >>> Uh.. there's no binding written down, it's just encoded into uic.c.
> >>> But UIC doesn't use OpenPIC sensitivity encoding.  Like FSL's IPIC, 
> >>> it
> >>> uses Linux IRQ_TYPE values from include/linux/irq.h which makes 8
> >>> "level sensitive, active-low".
> >>
> >> On a related note: aren't we taking a risk here of seeing those values
> >> change in linux ?
> >
> > We've discussed this before.  If that happens, the binding must remain
> > on the old values.  It means the driver will then need a translation
> > which it doesn't now, but we can deal with it.
> 
> It also means it should be written down in the binding _already_.

Well, yes, there should be, but isn't, a written binding for this,
amongst many other things.

> Come on, how much work is that?

Greater than zero.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

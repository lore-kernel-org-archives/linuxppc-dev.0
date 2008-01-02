Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A532DDE9A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 22:31:01 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m05BUs77016426
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Jan 2008 22:30:54 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m05BYbUL268000
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Jan 2008 22:34:37 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m05BUjT5022215
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Jan 2008 22:30:45 +1100
Date: Wed, 2 Jan 2008 22:42:08 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: Enable RTC for Ebony and Walnut
Message-ID: <20080102114208.GD23168@localhost.localdomain>
References: <20071221022130.GI2665@localhost.localdomain>
	<20071221212922.GC11910@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221212922.GC11910@lixom.net>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 03:29:22PM -0600, Olof Johansson wrote:
> Hi,
> 
> On Fri, Dec 21, 2007 at 01:21:30PM +1100, David Gibson wrote:
> > Index: working-2.6/arch/powerpc/platforms/Kconfig
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/platforms/Kconfig	2007-12-10 10:52:44.000000000 +1100
> > +++ working-2.6/arch/powerpc/platforms/Kconfig	2007-12-21 13:11:34.000000000 +1100
> > @@ -315,6 +315,9 @@ config FSL_ULI1575
> >  config CPM
> >  	bool
> >  
> > +config OF_RTC
> > +	bool
> > +
> 
> New config options should have descriptions, even if they're silent
> ones.

Uh.. but if there's a description, won't kconfig prompt for the
option?  This one should only ever be selected by the platform
options.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

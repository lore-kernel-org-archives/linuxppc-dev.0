Return-Path: <jdub@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B625367B9A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 23:22:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87DMGQQ010686
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 09:22:16 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k87DMF50273280
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 07:22:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k87DMFZ2015760
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 07:22:15 -0600
Subject: Re: [PATCH] PPC: Fix Kconfig whitespace warnings
From: Josh Boyer <jdub@us.ibm.com>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
In-Reply-To: <45001455.5000408@smiths-aerospace.com>
References: <1157632584.6098.35.camel@zod.rchland.ibm.com>
	<45001455.5000408@smiths-aerospace.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 08:23:44 -0500
Message-Id: <1157635424.6098.39.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 08:45 -0400, Jerry Van Baren wrote:
> Josh Boyer wrote:
> > Fix the following whitespace warnings when compiling with ARCH=ppc
> > 
> > arch/ppc/Kconfig:1207:warning: leading whitespace ignored
> > arch/ppc/Kconfig:1226:warning: leading whitespace ignored
> > arch/ppc/Kconfig:1231:warning: leading whitespace ignored
> > 
> > Signed-off-by: Josh Boyer <jdub@us.ibm.com>
> > 
> > ---
> >  arch/ppc/Kconfig |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > --- linux-2.6.orig/arch/ppc/Kconfig
> > +++ linux-2.6/arch/ppc/Kconfig
> > @@ -1204,7 +1204,7 @@ config PCI_DOMAINS
> >  	default PCI
> >  
> >  config MPC83xx_PCI2
> > -	bool "  Supprt for 2nd PCI host controller"
> > +	bool "Supprt for 2nd PCI host controller"
>                    ^ Add an "o"?

I was only looking at whitespace, but I can fix the typo too I suppose.
Thanks for noticing.

josh

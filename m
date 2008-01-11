Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C49BDE17F
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 04:55:38 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0BHtZuU021350
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:55:35 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0BHtZDD107438
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:55:35 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0BHtZt6022505
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:55:35 -0500
Date: Fri, 11 Jan 2008 11:54:51 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
Message-ID: <20080111115451.15756368@zod.rchland.ibm.com>
In-Reply-To: <47870994.9010009@pikatech.com>
References: <47852C41.8000506@pikatech.com> <47852CB3.3000208@pikatech.com>
	<20080110024753.GC17816@localhost.localdomain>
	<4786B147.5070206@pikatech.com>
	<20080111002037.GB23402@localhost.localdomain>
	<4786FCD0.5020100@pikatech.com>
	<20080111053231.GC25055@localhost.localdomain>
	<47870994.9010009@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 11 Jan 2008 01:15:48 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> David Gibson wrote:
> > Or possibly what you actually want is:
> > 	fpga@2,0 {
> > 		reg = <2 0 2200>;
> > 		...
> > 	};
> >   
> That is what I want. I was missing a call to 
> ibm4xx_fixup_ebc_ranges("/plb/opb/ebc"); (see updated patch3/5 to follow.
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

This looks pretty darn good, minus the missing GPIO node (see comment
in patch 1).

josh

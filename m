Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D50FCDDF38
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:54:50 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l0UCuO0R7082188
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:56:24 -0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0U0wIK1249282
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:58:18 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0U0snlE013305
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:54:49 +1100
Date: Tue, 30 Jan 2007 11:54:47 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Message-ID: <20070130005447.GB20332@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1170116712.26655.293.camel@localhost.localdomain>
	<7BADAAC7-D139-4C1A-A799-93F46508880E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7BADAAC7-D139-4C1A-A799-93F46508880E@kernel.crashing.org>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Murali N Iyer <mniyer@us.ibm.com>, Hartmut Penner <HPENNER@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 29, 2007 at 06:45:30PM -0600, Kumar Gala wrote:
> 
> On Jan 29, 2007, at 6:25 PM, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2007-01-08 at 07:38 +0100, Segher Boessenkool wrote:
> >>>  - compatible        : compatible list, contains 2 entries, first is
> >>> "emac-CHIP" where
> >>>                        CHIP is the host ASIC (440gx, 405gp, axon)  
> >>> and
> >>> second is either
> >>>                        "emac" or "emac4".
> >>>                        For axon, thus, we have: "emac-axon","emac4"
> >>
> >> "ibm,emac-axon" etc. please.
> >
> > What would you do for things like 440gx ? ibm,440gx or amcc,440gx ?
> 
> Does emac really vary that much between the chips its in?  I know  
> chatting with Ben that axon did some evil things, but how much  
> difference exists on 4xx implementations?

Very little, I think, but I believe the idea is to include the
detailed information, just in case in future we discover some errata
or other peculiarities in one chip's version of emac.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

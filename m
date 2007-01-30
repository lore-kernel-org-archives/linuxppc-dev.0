Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CC90DDF89
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:25:17 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l0U0e3ZK225372
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:40:03 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0U0SiS4239306
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:28:44 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0U0PEDq023093
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:25:15 +1100
Subject: Re: EMAC OF binding....
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 11:25:12 +1100
Message-Id: <1170116712.26655.293.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
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

On Mon, 2007-01-08 at 07:38 +0100, Segher Boessenkool wrote:
> >  - compatible        : compatible list, contains 2 entries, first is 
> > "emac-CHIP" where
> >                        CHIP is the host ASIC (440gx, 405gp, axon) and 
> > second is either
> >                        "emac" or "emac4".
> >                        For axon, thus, we have: "emac-axon","emac4"
> 
> "ibm,emac-axon" etc. please.

What would you do for things like 440gx ? ibm,440gx or amcc,440gx ?

Ben.

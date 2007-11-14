Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B91ECDDDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 12:17:28 +1100 (EST)
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071113222149.271610@gmx.net>
References: <20071113214845.85820@gmx.net>
	<fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>
	<fa686aa40711131359l43f289e7j48b0df3ff57ea7c7@mail.gmail.com>
	<9e4733910711131410r3b955fe7me20defb36d646939@mail.gmail.com>
	<20071113222149.271610@gmx.net>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 12:17:09 +1100
Message-Id: <1195003029.28865.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-11-13 at 23:21 +0100, Gerhard Pircher wrote:
> -------- Original-Nachricht --------
> > Datum: Tue, 13 Nov 2007 17:10:29 -0500
> > Von: "Jon Smirl" <jonsmirl@gmail.com>
> > An: "Grant Likely" <grant.likely@secretlab.ca>
> > CC: "Gerhard Pircher" <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> > Betreff: Re: Hardware debuggers for PPC74xx G4 CPUs
> 
> > On 11/13/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > On 11/13/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > > Abatron BDI-2000.
> > >
> > > Oops, but that's not all that cheap.  ($2750USD).  You might try
> > > looking at the Macraigor Wiggler
> > > (http://www.macraigor.com/wiggler.htm), but it has limited powerpc
> > > support.
> > 
> > Here are the choices:
> > http://www.macraigor.com/cpus.htm
> Looks like the Abatron BDI-2000 is the cheapest hardware debugger that
> supports 74xx G4 CPUs. :-(

Do you have the appropriate connector for it on the motherboard as
well ? If not, then you are out of luck...

Ben.

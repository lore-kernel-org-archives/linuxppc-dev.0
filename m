Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BAEDDDDFD
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:16:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72KGPQI025316
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:16:25 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72KGOOl210962
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:16:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72KGOfI004044
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:16:24 -0600
Date: Thu, 2 Aug 2007 15:16:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070802151623.72a28db3@weaponx.rchland.ibm.com>
In-Reply-To: <20070801050422.GI31391@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
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

On Wed, 1 Aug 2007 15:04:22 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Aug 01, 2007 at 06:57:33AM +0200, Segher Boessenkool wrote:
> > >> +	UIC0: interrupt-controller0 {
> > >> +		compatible = "ibm,uic-440gp","ibm,uic";
> > >
> > > The first compatible entry should always be the precise model, so
> > > in this case "ibm,uic-440epx".
> > 
> > This isn't really _required_, but it is a very good idea in
> > almost all cases (the exception is for very generic or legacy
> > devices).
> 
> Well, yes.  That's a "should" not a "must" in rfc-speak.
> 
> > > If it is (supposed to be) identical to
> > > the UIC in the 440GP, it can also have an "ibm,uic-440gp" entry,
> > > but since I believe all the UICs are supposed to operate the
> > > same, I think that's implicit in the "ibm,uic" entry.
> > 
> > Sure, but there is no harm in having the better qualified 440gp
> > name in there as well -- bytes are cheap :-)
> > 
> > >> +	SDR0: sdr {
> > >
> > > What is the SDR?
> > >
> > >> +		compatible = "ibm,sdr-440ep";
> > >> +		dcr-reg = <00e 002>;
> > >> +	};
> > >> +
> > >> +	CPR0: cpr {
> > >
> > > And the CPR?
> > 
> > Yeah, better names please -- if possible, something that someone
> > without knowledge of this SoC will understand what it is.
> 
> I think the names are probably ok - I'm assuming they're in keeping
> with the convention I've used of using the same names / abbreviations
> as in the CPU user manual.  I'm asking just for my own information,
> although a comment might not be a bad idea.

Yes, they are the names used in the user manual.  I'd prefer to keep
them as is.

And yeah, they are similar to the macros found on 440GP.  But not the
same, hence a different name.

josh

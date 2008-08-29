Return-Path: <munroesj@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 975E9DDF28
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 06:29:05 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7TKLrrV024564
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 16:21:53 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7TKT0dk224688
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 14:29:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7TKSxbo020233
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 14:28:59 -0600
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
From: Steven Munroe <munroesj@linux.vnet.ibm.com>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200808291348.27652.david.jander@protonic.nl>
References: <200808251131.02071.david.jander@protonic.nl>
	<1219703291.13162.106.camel@pasglop>
	<1219871079.28869.149.camel@spokane1.rchland.ibm.com>
	<200808291348.27652.david.jander@protonic.nl>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 15:34:21 -0500
Message-Id: <1220042061.28869.184.camel@spokane1.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: munroesj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-29 at 13:48 +0200, David Jander wrote:
> On Wednesday 27 August 2008 23:04:39 Steven Munroe wrote:
> > On Tue, 2008-08-26 at 08:28 +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2008-08-25 at 15:06 +0200, David Jander wrote:
> > > > Hi Matt,
> > > >
> > > > On Monday 25 August 2008 13:00:10 Matt Sealey wrote:
> > > > > The focus has definitely been on VMX but that's not to say lower
> > > > > power processors were forgotten :)
> > > >
[SNIP]
> > >
> > > It would be useful of somebody interested in getting things things
> > > into glibc did the necessary FSF copyright assignment stuff and worked
> > > toward integrating them.
> >
> > Ben makes a very good point!
> 
> Sounds reasonable... but I am still wondering about what you mean 
> with "things"?
> AFAICS there is almost nothing there (besides the memcpy() routine from Gunnar 
> von Boehn, which is apparently still far from optimal). And I was asking for 
> someone to correct me here ;-)
> 
> > There is also a framework for adding and maintaining optimizations of
> > this type:
> > 
> > http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html
> 
> I had already stumbled across this one, but it seems to focus on G3 or newer 
> processors (power4). There is no optimal memcpy() for G2/PPC603/e300.
> 
Well folks volunteer to work on code for the hardware they have, use,
and care about. I don't have any of that hardware...

this framework can be used to add optimizations for any valid gcc
-mcpu=<cpu-type> target.

> >[...]
> > So it does no good to complain here. If you have core you want to
> > contribute, Get your FSF CR assignment and join #glibc on freenode IRC.
> 
> I am not complaining. I was only wondering if it is just me or there really is 
> very little that has been done (for either uClibc, glibc, or whatever for 
> powerpc) to improve performance of (linux-) applications on "lower"-power 
> platforms (G2 core), AFAICS there is a LOT that can be gained by simple 
> tweaks.
> 
This is a self help group (free as in freedom) We help each other. And
you can help yourself. There is no free lunch.

> > And we will help you.
[SNIP]
> 
> The problem is: I have very little experience with powerpc assembly and only 
> very limited time to dedicate to this and I am looking for others who have 
> 
Well this will be a good learning experience for you. We will try to
answer questions.

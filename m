Return-Path: <munroesj@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6D2FDDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 06:59:25 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7RKxMOJ015799
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 16:59:22 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7RKxMHU220816
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 14:59:22 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7RKxLMm027125
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 14:59:22 -0600
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
From: Steven Munroe <munroesj@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1219703291.13162.106.camel@pasglop>
References: <200808251131.02071.david.jander@protonic.nl>
	<48B290BA.7060202@genesi-usa.com>
	<200808251506.34450.david.jander@protonic.nl>
	<1219703291.13162.106.camel@pasglop>
Content-Type: text/plain
Date: Wed, 27 Aug 2008 16:04:39 -0500
Message-Id: <1219871079.28869.149.camel@spokane1.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Jander <david.jander@protonic.nl>
Reply-To: munroesj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-08-26 at 08:28 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2008-08-25 at 15:06 +0200, David Jander wrote:
> > Hi Matt,
> > 
> > On Monday 25 August 2008 13:00:10 Matt Sealey wrote:
> > > The focus has definitely been on VMX but that's not to say lower power
> > > processors were forgotten :)
> > 
> > lower-power (pun intended) is coming strong these days, as energy-efficiency 
> > is getteing more important every day. And the MPC5121 is a brand-new embedded 
> > processor, that will pop-up in quite a lot devices around you most 
> > probably ;-)
> 
> It would be useful of somebody interested in getting things things
> into glibc did the necessary FSF copyright assignment stuff and worked
> toward integrating them.
> 

Ben makes a very good point!

There is a process for contributing code to GLIBC, which starts with an
FSF copyright assignment.

There is also a framework for adding and maintaining optimizations of
this type:

http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html

Since this original effort the powerpc changes have been merged into
mainline glibc (GLIBC-2.7) and no longer require a separate
(powerpc-cpu) addon. But the --with-cpu= configure option still works.
This mechanism also works with the glibc ports addon and eglibc.

So it does no good to complain here. If you have core you want to
contribute, Get your FSF CR assignment and join #glibc on freenode IRC.

And we will help you.

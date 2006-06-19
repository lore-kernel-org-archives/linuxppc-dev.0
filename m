Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11A6367AA0
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:03:52 +1000 (EST)
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Interrupt mapping documentation 
In-Reply-To: Your message of "Tue, 20 Jun 2006 00:22:02 +0200."
	<3E324A7E-388E-4917-B380-B0831A5F9D19@kernel.crashing.org>
References: <1150598731.23600.146.camel@localhost.localdomain>
	<EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
	<3E324A7E-388E-4917-B380-B0831A5F9D19@kernel.crashing.org>
Date: Mon, 19 Jun 2006 18:03:46 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FsSmY-0000Oz-P2@jdl.com>
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> > Wow, you've been busy!  This mostly looks good to me - just a few
> > *minor* comments below. I've snipped out parts I'm not commenting on,
> > to shrink this email down.....
> 
> Yeah.  I've got some nits too, although mostly spelling.  Will get to
> those later, if I find the time :-)

BTW, Becky sent him an off-list correction for a series
of spelling and grammar related changes.  You might wait
for that... :-)


> Inheritance from the parent does not exist, in real OF.  Absence of
> #address-cells means "default to 2".  This needs to be fixed in DTC.
>
> [...]
>
> Just *require* #address-cells for everything with addressable sub-nodes,
> at least in DTC.  Doesn't cost much, and no confusion anymore.

Woot!  Send me a patch! :-)

jdl

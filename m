Return-Path: <jdl@jdl.com>
Received: from jdl.com (colo.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8996A67B55
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 02:48:38 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1GArEQ-0006OP-7H
	for linuxppc-dev@ozlabs.org; Wed, 09 Aug 2006 11:48:35 -0500
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: RFC: Location for Device Tree Sources? 
In-Reply-To: Your message of "Wed, 09 Aug 2006 09:38:39 PDT."
	<20060809163839.GB17759@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<1155122309.4040.94.camel@localhost.localdomain>
	<1155128205.3944.1.camel@zod.rchland.ibm.com>
	<20060809163839.GB17759@mag.az.mvista.com>
Date: Wed, 09 Aug 2006 11:48:34 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GArEQ-0006OP-7H@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Mark A. Greer" mumbled:
> > We're only talking about the _source_ files.  The .dts files.  Not the
> > binary trees themselves.
> > 
> > The basic summary is that having a .dts in the kernel for every
> > defconfig would be good.  (I think that was the summary anyway.)
> 
> That's my understanding too.  A 1-1 matching of default config files
> and dts files kept in the kernel src trees.

And the keen observer who watches Paul's tree will have
noticed that the first DTS file, mpc8641_hpcn.dts, has already
been added to arch/powerpc/boot/dts!

> Any extra dts files 

... of which there are none...

> ...would be kept whereever dtc src is stored (i.e., jdl.com).
>  I haven't heard jdl agree to this, though.  :)

Sure.  No problem by me.

Though I do have a question WRT the notion of the libdt...

So, if I understand this proposal correctly, making libdt.a
would mean that we will now have to link the kernel against
this new, external dependency library.  It would also mean
that we'd have to link U-Boot against this new, external
library as well.

Did I misunderstand or is everyone hip, jiggie and down with that?

jdl

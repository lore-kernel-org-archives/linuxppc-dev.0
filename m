Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 01E20DDEDE
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 05:04:01 +1000 (EST)
Subject: Re: [U-Boot-Users] [PATCH: dtc take 2] Assemble the blob in memory
	before writing	it out.
From: Jon Loeliger <jdl@freescale.com>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
In-Reply-To: <4627B9C7.8010800@smiths-aerospace.com>
References: <20070419015951.GA9339@dellserver.lan>
	<1177007241.14328.21.camel@ld0161-tx32>
	<4627B9C7.8010800@smiths-aerospace.com>
Content-Type: text/plain
Message-Id: <1177009395.14328.29.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 19 Apr 2007 14:03:15 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>,
	u-boot-users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-19 at 13:49, Jerry Van Baren wrote:

> > 
> > Sorry.  I've been out sick for a couple days here and am
> > just now catching up.  I've read through the last week's
> > worth of mail here now, so let me see if I have properly
> > summarized where things stand and what's needed for the DTC:
> > 
> > These patches need to be applied:
> > 
> >     [PATCH dtc] Add -o <output file> to the usage message.
> >     Sat, 14 Apr 2007 18:16:47 -0400
> > 
> >     [PATCH dtc take 3] Fix reserve map output for asm format.
> >     Tue, 17 Apr 2007 18:14:41 -0400
> > 
> >     [PATCH: dtc take 2] Assemble the blob in memory before writing it out.
> >     Wed, 18 Apr 2007 21:59:51 -0400
> > 
> > The last patch there replaces the "Improve -S handling" patches.
> > But does the last patch replace or depend on the second one?
> > 
> > And I agree with David that last patch is a better approach.
> > 
> > Thanks,
> > jdl
> 
> Yes, you have that right.

Good.  The drugs aren't too strong yet. :-)

> Patch #1 is good to go
>    [PATCH dtc] Add -o <output file> to the usage message.
>    Sat, 14 Apr 2007 18:16:47 -0400
> 
> Patch #2 and #3...
>    [PATCH dtc take 3] Fix reserve map output for asm format.
>    Tue, 17 Apr 2007 18:14:41 -0400
>    [PATCH: dtc take 2] Assemble the blob in memory before writing it out.
>    Wed, 18 Apr 2007 21:59:51 -0400
> 
> ...you force me to make a confession.

It's good for the soul. :-)


> Your option:
> 1) Take the last two patches as is and remove the fprintf yourself
> 2) I'll fix it tonight and provide a New Improved patch

I'll go with Door Number 1!  No problem.

Thanks,
jdl

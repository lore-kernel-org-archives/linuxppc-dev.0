Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp9.wanadoo.fr (smtp9.wanadoo.fr [193.252.22.22])
	by ozlabs.org (Postfix) with ESMTP id BBF4B67A78
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Feb 2005 17:14:14 +1100 (EST)
Date: Sat, 26 Feb 2005 07:04:35 +0100
To: Christian <evil@g-house.de>
Message-ID: <20050226060435.GA16401@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net>
	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
	<20050224074728.GA31434@pegasos>
	<Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
	<20050224160657.GB11197@pegasos> <421E7033.1030600@g-house.de>
	<20050225063609.GA21244@pegasos>
	<49984.195.126.66.126.1109332744.squirrel@housecafe.dyndns.org>
	<20050225121536.GA20174@pegasos> <421FEF81.2070806@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <421FEF81.2070806@g-house.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>, Meelis Roos <mroos@linux.ee>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
	PCI IRQ map
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 26, 2005 at 04:39:45AM +0100, Christian wrote:
> Sven Luther wrote:
> >Some backports that i got from the list. The complete list of patches is 
> >at :
> >
> >  http://svn.debian.org/wsvn/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches/?rev=0&sc=0
> 
> dooh, these websvn patches are giving me a headache.... will have to 
> learn /usr/bin/svn first :-\

Well : 

  svn co svn://svn.debian.org/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches

> >--- kernel-source-2.6.8.orig/arch/ppc/platforms/prep_pci.c	2004-12-28
> 
> yes, the prep_pci.c and its irq-mappings. the PowerStackII lines were 
> changed back and forth, and a current 2.6-BK is only different in one 
> line to the patch you mentioned:

I guess the one line is the one for the IDE device, ..., indeed. The one line
in question is to enable the onboard IDE controller, which exist but is
probably not used, since the place on the board where it should be has no
connector soldered. I hear that there is an IDE powerstack II model though, so
...

> http://nerdbynature.de/bits/hal/2.6.11-rc5.patched/powerpc-prep-powerstack-irq_2.6.11-rc5.patch
> 
> unfortunately it did not help either and i'll switch back to vanilla 
> 2.6.8 again and hopefully find out exactly when scsi stopped working.

As i understand leigh's and other post, i believe that this is the fix, but
that other stuff went in too which did break.

> http://nerdbynature.de/bits/hal/2.6.11-rc5/
> http://nerdbynature.de/bits/hal/2.6.11-rc5.patched/

Friendly,

Sven Luther

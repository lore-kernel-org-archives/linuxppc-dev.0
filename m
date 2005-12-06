Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AE84D6888F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 08:15:02 +1100 (EST)
To: Matt Jerdonek <maj1224@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 06 Dec 2005 08:42:12 PST."
	<20051206164212.82779.qmail@web33505.mail.mud.yahoo.com>
Date: Tue, 06 Dec 2005 22:14:59 +0100
Sender: wd@denx.de
Message-Id: <20051206211459.E8976353F54@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Denx vs kernel.org 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051206164212.82779.qmail@web33505.mail.mud.yahoo.com> you wrote:
> I'm looking at embedding linux into a PowerPC-based
> system.  I found the DENX website to be very helpful,
> but I'm struggling to understand a few items:

It would be helpful if you precisely stated which of the  misc  trees
you are talking about.

> 1) The source from kernel.org appears to have support
> for the powerpc (arch/powerpc/8xx_io).  But when using
> 'make xconfig' I cannot select PowerPC from the list
> of processors.  Is this just a limitation on the the
> configuration utility?

Seems like you are trying to use the linux-2.6-denx tree  and  forgot
to  pass  a "ARCH=ppc" argument to "make" (and did not set "ARCH=ppc"
in your shell environment either).

> 2) What is the difference between the sources on DENX
> and kernel.org?  Are there other places where PPC

We have some stuff added which was submitted as patches to  the  list
but  not  all  of  this  has  been  accepted  for  or merged into the
kernel.org tree yet.

> linux kernel source is stored?  I'm not opposed to
> using the DENX source, I'm just trying to understand
> it.

You may want to read http://penguinppc.org/kernel/

> 3) I've used eCos before and I'm familiar with
> RedBoot.  Is there a compelling reason to use U-Boot
> over RedBoot?  For example, I think U-boot contains an
> NFS client while RedBoot does not.  Is this important?

U-Boot contains a lot more. If these features are  important  to  you
depends on what you want to do.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The thing is, as you progress in the Craft,  you'll  learn  there  is
another rule... When you break rules, break 'em good and hard.
                                    - Terry Pratchett, _Wyrd Sisters_

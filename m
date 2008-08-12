Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4416EDE16A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 00:05:00 +1000 (EST)
Date: Tue, 12 Aug 2008 18:04:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20080812140457.GA9103@oksana.dev.rtsoft.ru>
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<48A0676E.5020308@harris.com>
	<20080811170756.GA29827@oksana.dev.rtsoft.ru>
	<1218492032.8041.11.camel@pasglop> <48A19788.6050502@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48A19788.6050502@harris.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks,
	Sam" <SSparks@aclaratech.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 12, 2008 at 10:00:40AM -0400, Steven A. Falco wrote:
> Benjamin Herrenschmidt wrote:
> >   
> >> 1. IDE status read does not work. (But am I understand correctly
> >>    that IDE works well if IRQ is unspecified? Then this is hardly
> >>    an issue.)
> >> 2. IDE interrupt comes when it should not. I'd recommend to use
> >>    oscilloscope to find out what is happening there, that is, if
> >>    the drive actually deasserts its irq line after status read.
> >>    If so, than this could be a PIC problem.
> >>
> >> What is the platform on which you're observing the issue, btw?
> >>     
> >
> > Another possibility is that you got the wrong interrupt number
> > in the device-tree...
> >
> > Ben.
> >   
> 
> The platform is the AMCC Sequoia board.  We've built a little adapter to
> connect a compact flash card to the processor bus.  I believe the
> interrupt selection in the device tree is correct, and I've checked over
> the u-boot settings for the IRQ line (active high, level sensitive). 

IDE IRQs are active-low.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 86BB42BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 02:47:17 +1100 (EST)
In-Reply-To: <41E7E64F.2080807@anagramm.de>
References: <41E7E64F.2080807@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <891B097E-6643-11D9-A3DB-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 14 Jan 2005 09:47:03 -0600
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6.x to MPC8540/Microsys Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clemens,

I would to just use 2.6.10 as starting point and get that working.  The=20=

amount of changes to board code is about 100 lines to go from OCP to=20
platform_device.  I should be releasing patches for this upstream today=20=

and will CC the linuxppc-embedded list, so if you really want them you=20=

can get them, but I dont think its worth the pain for you.

- kumar

On Jan 14, 2005, at 9:33 AM, Clemens Koller wrote:

> Kumar Gala wrote:
>
> > I would suggest 2.6.10 if you want an official kernel release.=A0 Is=20=

> this
> > board generally available to people?
>
>  Yes: www.microsys.de miriac Module: PM854 (and some others)
>
> > Be aware there are some infrastrucal changes I'm working on that=20
> moves
> > the 85xx sub-arch support from using OCP to platform_device.=A0=20
> However,
> > these have minor changes on the board files.
>
> I've read your last mails in this list... therefore I am asking. :-)
>  I just don't want to re-invent the wheel twice. In the pm854 specific
>  things there are also some OCP updates. (Well, I am still reading =
lots
> of code... newland for me)
>  I try to contact the developer Josef Wagner at Microsys who was=20
> working
>  on the 2.4.26-sth.
>
> > I would take a look at how 2.6 is structured for 85xx.=A0 I tried to=20=

> do a
> > better job and provide more common code for a board port to=20
> leverage.=A0
> > So for something like PCI, you should hopefully just have to setup=20=

> your
> > memory map and IRQ routing.
>
> I am comparing 2.4.26-sth with 2.6.10 now. The changes are manageable=20=

> as
> far as I got it. Where can I get the current work from you?!
>
> Greets,
>
> Clemens Koller
> _______________________________
> R&D Imaging Devices
>  Anagramm GmbH
>  Rupert-Mayer-Str. 45/1
>  81379 Muenchen
>  Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
>  Fax: +49-89-741518-19
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

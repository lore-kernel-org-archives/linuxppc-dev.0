To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdb problems / BDM PPCBoot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 11 Oct 2001 12:05:25 +0200."
             <6B546A602AD2D211BFF00008C7A42889041D6C6B@hrtades2.atea.be>
Date: Thu, 11 Oct 2001 14:53:27 +0200
Message-Id: <20011011125332.B981E10886@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <6B546A602AD2D211BFF00008C7A42889041D6C6B@hrtades2.atea.be> you wrote:
>
> I am doing exactly the same thing as Joakim Tjernlund a few months ago:

> > I am trying to debug ppclinux 2.4 and ppcboot on RPX CLLF board

You have better chances to get a reply to PPCBoot  related  questions
when you ask on the PPCBoot mailing list.

> After I enabled the -ggdb switch and removed -mrelocatable,  I am able to
> look at variables, but it is all rubbish. Also the source code ddd points to

The "-mrelocatable" is necessary; when you remove it, you will  break
lose a lot of problems.

I do a lot of debugging with  the  BDI2000  just  using  the  default
options as supplied with PPCBoot, i. e. just "-g" (and of course WITH
-mrelocatable).

> is completely wrong. When it should jump to board_init_f (PPCBoot, board.c),
> it thinks it jumps to eth_rx+12. This corresponds with what I see in the

This has been expalined a lot of times on the mailing list. You  have
to  know  what  you're doing - if you're ruinning from flash, or from
RAM.

> ppcboot.map-file. The offset between these two is 0xa9b0. When I reload the
> symbol file, "add-symbol-file ppcboot 0xff00a960" instead of
> "add-symbol-file ppcboot 0xff000000", I start seeing the correct source-code
> lines, but the variables are still completely wrong.

...as wrong as both commands, I think.

> Any ideas? Could it be a problem with the compiler and debugger version that
> MontaVista ships with CDK1.2? That the -ggdb switch is needed is a hack in
> the first place, right?

Right, it is not needed, and don't worry about the tools. HHL-1.2 may
be old but it works fine.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
WARNING:  This Product Warps Space and Time in Its Vicinity.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

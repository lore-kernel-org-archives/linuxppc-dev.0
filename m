To: "Muhammad Sarwar" <msarwar@mangrovesystems.com>
Cc: "Steven Rothweiler" <Stevenr@raritan.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: AgileDB and Abatron BDI 2000 ICE 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jul 2003 10:31:56 EDT."
             <8529B5552D4EAA4DAEDF49650C64B2B437128C@TARPON.mangrovesystems.com>
Date: Fri, 11 Jul 2003 16:48:29 +0200
Message-Id: <20030711144834.C3B46C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8529B5552D4EAA4DAEDF49650C64B2B437128C@TARPON.mangrovesystems.com> Muhammad Sarwar wrote:
>
> Main advantage of Agile is that it integrates Abatron's commands and
> GDB debugging services.

I have not used AgileDB yet. How does this integration work? I  mean,
how much more do you get than when using GDB's "monitor" command?

> Nice GUI for all BDI and GDB features at one place

You can use DDD and add some custom-defined buttons.

> Ability to move registers, structs etc to same watch window(by click
> and drag)  Tools to automate some processes like loading of register
> init file, playing back command script

I suspect this might be just using GDB features?

> Ability to set PC, other registers etc

Standard GDB features...

> Ability to use the same software for debugging of user applications

Standard GDB feature.

> However there are some problems:
>
> Program crashes frequently, they are offering new version of SW which
> is supposed to be more stable. Problems in setting break points.
> Problem in getting stack info display. Bug in display of struct
> info
>
> I think overall it brings good value for boot and kernel debugging.

I'm sorry, but from what you listed I don't see any advantages...

[But I have to admit that I've been using  GDB  and  CLI's  for  some
time...]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The bad reputation UNIX has gotten is totally undeserved, laid on by
people who don't understand, who have not gotten in there  and  tried
anything."          -- Jim Joyce, owner of Jim Joyce's UNIX Bookstore

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

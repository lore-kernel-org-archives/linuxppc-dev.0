Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <159C486347C8D3119B1D005004A469400244BC6B@OLIVE>
From: Steven Rothweiler <Stevenr@raritan.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: AgileDB and Abatron BDI 2000 ICE 
Date: Fri, 11 Jul 2003 11:12:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang,

>From the AgileDB product data sheet (I can send it to you if
you'd like), it is clearly a GUI front end for GDB, or any
other debugger you want to use.  They allow you to issue any
GDB (or any tool's) command-line command from a prompt, if
that's what you're familiar with.  From their data sheet:

Channels and Connections
------------------------
AgileDB communicates to any number of debug devices or tools
using Connections and Channels.

Connections are physical connections to devices, tools or
target services.  Channels are logical paths across a
connection.  Examples of some typical tools and services you
can connect to AgileDB:

* The BDI 2000 ICE Command Set
* The GDB Command Set
* Target Serial I/O (over telnet)
* Any Tool or Service that uses Telnet
* Boot Agents Like: PPC/U-BOOT
* User-Defined Tests and Target Services

Theoretically, you're supposed to have productivity gains
by using their GUI (if you invest the time to learn it, just
as you've invested time to learn a CLI) over the equivalent
CLI way of doing it.  Their "claim to fame" is that they've
solved the "window-explosion" problem that most GUI
debuggers suffer from.  In a particular debug session, you
can put all of the things that are most important to you
into a single window.  I have no idea if this enhances
productivity, but I know that one of the reasons that I
prefer CLIs is that I spend more time opening, closing,
re-sizing, and just plain fiddling with the GUI windows.

If it were up to me, I'd just use the CLI.  But I work for
a company that has to consider the productivity of engineers
whom they're paying to train.  If they train them on a CLI,
and their productivity is not as good as if they had trained
them on a GUI, then they are not helping the company.

(And I'd like to keep my job ;)
--
Steven Rothweiler               Raritan Computer Inc
Embedded Engineer               400 Cottontail Lane
mailto:stevenr@raritan.com      Somerset, NJ   08873
732-764-8886 x1256


> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Friday, July 11, 2003 10:48 AM
> To: Muhammad Sarwar
> Cc: Steven Rothweiler; linuxppc-embedded@lists.linuxppc.org
> Subject: Re: AgileDB and Abatron BDI 2000 ICE
>
> In message
> <8529B5552D4EAA4DAEDF49650C64B2B437128C@TARPON.mangrovesystems
> .com> Muhammad Sarwar wrote:
> >
> > Main advantage of Agile is that it integrates Abatron's commands and
> > GDB debugging services.
>
> I have not used AgileDB yet. How does this integration work? I  mean,
> how much more do you get than when using GDB's "monitor" command?
>
> > Nice GUI for all BDI and GDB features at one place
>
> You can use DDD and add some custom-defined buttons.
>
> > Ability to move registers, structs etc to same watch window (by click
> > and drag)  Tools to automate some processes like loading of register
> > init file, playing back command script
>
> I suspect this might be just using GDB features?
>
> > Ability to set PC, other registers etc
>
> Standard GDB features...
>
> > Ability to use the same software for debugging of user applications
>
> Standard GDB feature.
>
> > However there are some problems:
> >
> > Program crashes frequently, they are offering new version
> of SW which
> > is supposed to be more stable. Problems in setting break points.
> > Problem in getting stack info display. Bug in display of struct
> > info
> >
> > I think overall it brings good value for boot and kernel debugging.
>
> I'm sorry, but from what you listed I don't see any advantages...
>
> [But I have to admit that I've been using  GDB  and  CLIs  for  some
> time...]
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "The bad reputation UNIX has gotten is totally undeserved, laid on by
> people who don't understand, who have not gotten in there  and  tried
> anything."          -- Jim Joyce, owner of Jim Joyce's UNIX Bookstore
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

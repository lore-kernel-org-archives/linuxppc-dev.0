Message-Id: <200101081926.f08JQco25541@denx.local.net>
To: clark@esteem.com
cc: Linux Lurker <linuxlurker@yahoo.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Setup and Equipment needed for Linux on PowerPC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Jan 2001 10:00:45 PST."
             <5.0.0.25.1.20010108084955.00a7beb0@pop.esteem.com>
Date: Mon, 08 Jan 2001 20:26:38 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.0.0.25.1.20010108084955.00a7beb0@pop.esteem.com> Conn Clark wrote:
>
>          As far as distributions go there are many to choose from but I
> suggest you stay away from ones that charge royalties. A few that don't
> Hard Hat Linux,  Red Hat's Embedded Dev Kit. I belive Wolfgang Denk who
> frequently answers questions on this list has his own distribution CD for
> sale available at http://www.denx.de .

Right. We also have the build scripts used to generate it on our FTP server.

And we also have TQM8xxL (half credit card sized!) based  development
systems, with PPCBoot and Linux preinstalled. And we support the Open
Source / nearly free hardware BDM-Debugger project BDM4GDB.

>          Burrner? do you mean In Circuit Emulator (ICE) or debugger? If so
> I have heard that the Abatron BDI2000 is the way to go. Most others don't
> work after the MMU is turned on.

Correct. Or check the BDM4GDB project at SourceForge. If  you  cannot
build  the  parallel port adapter yourself, we offer small numbers at
production cost (<$50).

Hope thishelps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Virtual" means never knowing where your next byte is coming from.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

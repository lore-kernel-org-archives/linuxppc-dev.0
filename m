Message-ID: <3CD087B5.26B41130@esteem.com>
Date: Wed, 01 May 2002 17:26:29 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: excessive ram usage?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

	I am running into a problem of running out of ram. I don't
know if its a problem with the way I think things should be happening
or if I don't have things configured right.

	The way I think things should happen is this. When I login
through a telnet session Linux should load a copy of bash and use some
ram for the environment and our menu. When I login through a second
telnet sesion linux should use the code segment of bash and allocate new
data and stack segments for this instance of bash and our menu, then
allocate some more ram for this sessions environment.

	The way I think things are actually happening is this. When I
login through a telnet session linux loads a copy of bash and use some
ram for the environment and our menu. When I login through second telnet
session linux appears to be loading another complete copy of bash and
our menu as well as some more ram for the environment. The reason I
think this is it consumes about 600-700K more of ram which is the amount
that I would expect if linux was loading a complete copy of bash, our
menu and more ram for the environment.

	I am running kernel 2.2.13 . I think I saw somewhere that I had
to have virtual memory enabled to enable code sharing amongst program
instances but I don't know where if I did. If this is the case how do I
go about enabling it? (I only have a ramdisk to put a swapfile on)

	I sure many of you will say "replace bash and install uClib"
however we want to use bash and are not quite ready to use uClib.

	Also I was also wondering if there was a way to keep the kernel
from caching the ram disk.


PS.
BONUS QUESTION FOR AN EXTRA Thank You

What does the -O option do in the linker ld? I know it optimizes, but
how and what does changing the diferent levels do? I can't find this
documented anywhere.


Many Many Many Thanks,

	Conn


--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

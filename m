Message-ID: <762A181C0D966E459A2EB3B810142C77038614F1@nmrusdunsx12.nmrlan.net>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'James Perkins'" <james@loowit.net>,
	Arun Prasad Velu <arun@ossi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Cross compiling for VxWorks/PowerPC Target from a Linux/x86 M
	achine
Date: Tue, 13 Jul 2004 16:32:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James,

> ...and Wind River will provide it free to people they've distributed
> the binaries to...

Our company is a current Wind River customer that pays WRS for customer
support.  I put in a request for a list of which components of the Tornado
toolset were covered by GPL/LGPL and which weren't.  No immediate response.
After several requests, WRS responded that I would have to have "our lawyer
call their lawyer" in order to find out which ones were GPLed.  Since my
request was related to a background project, I let it drop.

I'll be interested in hearing if Arun has any luck at all.  I'm a bit
cynical.

Charlie

-----Original Message-----
From: James Perkins [mailto:james@loowit.net]
Sent: Tuesday, July 13, 2004 3:40 PM
To: Arun Prasad Velu
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compiling for VxWorks/PowerPC Target from a Linux/x86
Machine



Arun Prasad Velu wrote:

>I'd like to know how feasible is it to cross compile for a VxWorks/PowerPC
>Target from a Linux/x86 Machine?
>If there was any attempt earlier, I'd like to know about it (basically to
>get the source compiled for VxWorks/PowerPC from Linux/x86 machine).
>Any pointer on how to go about it would also be appreciated.
>
You can get the gcc toolchain that WR is using, it is GPL and Wind River
will provide it free to people they've distributed the binaries to --
which should be everyone who's also bought a valid VxWorks library
license. If you want to use your off-the-shelf gcc it may be somewhat
tricky to configure your gcc just like it is in Tornado, but on an
existing Tornado installation (even on Windows) you can probably get gcc
to cough up most of the details of how it was configured if you want to
build your own cross-toolchain.

VxWorks AE has supported Linux cross-development hosts for quite some time.

VxWorks 6.0 (soon in beta) supports Linux development hosts (official
support for Red Hat Enterprise Linux 3 although it probably will work
with some tweaking on other distributions). Details at
http://www.windriver.com/announces/02232004b.html. It also is integrated
with Wind River Workbench, which uses Eclipse as an IDE framework for
the cross-toolchain, debugger, code browsing -- although it's still easy
to use the cross-toolchain from a command line build (that's what many
VxWorks architecture engineers do - we edit target/config/bsp/config.h
and fire off make). You also have your choice of two toolchains, gcc or
Wind Power Compiler.

I haven't tried mixing objects from another gcc toolchain, say DENX,
with objects from WR, but I don't see why (in principle) they wouldn't
work, although I'd expect caveats with specific assembler opcodes, link
operations, and especially C++ interoperation (the gcc and wpc
toolchains do not intermix C++ objects).

Cheers,
James
(disclaimer: WR employs me but I am not an official spokesperson)

--
James Perkins         james@loowit.net         http://loowit.net/~james
-=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=-
    I have no fear of death.... It's how you live that really counts.
		    -- Katharine Hepburn, 1907-2003


** This list is shutting down 7/24/2004.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.

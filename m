Message-ID: <38A2FB72.EF461073@switchboard.ericsson.se>
Date: Thu, 10 Feb 2000 18:54:58 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Todd_Tomaino@vnci.net
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux w/ Motorola 860ADS target
References: <85256880.007E7FD2.00@ushq1.objectivecom.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




"Todd_Tomaino"@vnci.net wrote:
>
> Hello,

Hi!

> I am brand new to Linux as well as the list.  I am interested in using
> Linux with the 860ADS demo board as a target.

That is a pretty good board. But watch out for the ZIF socket!
I've got two boards: One PILOT and one REV-B. Only the REV-B works.

> Could anyone suggest a
> version of Linux that is well suited for this purpose.

ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mpc8xx-2.2.13.tgz

That version has not much ADS860 support, but I've made a patch
that is floating around. Check previous messages!

You also need to apply a low-memory patch if you
want to be able to do something.
Check the archives there too.

This site has info about booting and stuff.

http://www.s4l.de/powerpc.html

You will probably need 8xxrom to boot your board.

> Also, drivers for
> the PCMCIA interface would be a real plus.

Well, that's me!

I am actually running Linux on a ADS860 right now, trying out
my PCMCIA socket driver for the mpc8xx series.

Most things work, but I have not released the driver yet.
I plan doing so next week or so.

The driver will be as a patch against David Hinds pcmcia-cs package.

> In looking around under the
> search criteria for "Linux PPC" I am seeing versions such as Black Lab,
> Yellow Dog, Debian, etc.  These appear to be geared more towards desktop
> power pc units.  Is it possible to use one of these for an embedded
> application??

If you patch and replace glibc it should be possible.
You probably need heaps of memory, though.

We crosscompile the programs we need.

Good luck /

Magnus

> best regards,
>
> Todd

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <398E6051.6DA84197@student.ethz.ch>
Date: Mon, 07 Aug 2000 09:08:01 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X
 Server))
References: <Pine.LNX.4.21.0008041831040.29474-100000@idd-01.imbc.gr> <20000805184351.19510@192.168.1.10>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >> At 32 bit, it flickers badly on my Pismo, probably because it only has
> >8 megs
> >> of VRAM. (These messages appear in the log:
> >> (EE) r128(0): Unable to reserve depth buffer
> >> (EE) r128(0): Unable to reserve texture space in frame buffer
> >> ) Curious how it works out for people with more...
> >
> >Not enough memory for all the buffers indeed, you could try with a lower
> >res (if prismo allows that) to save some memory.
>
> The Pismo allows that by scaling the LCD, but I don't think code for that
> is implemented in the XFree r128 driver (I didn't check lately).

No it doesn't work, neither with aty128fb. Would that be hard to implement?


Michel


--
If the box says `Windows 95 or better'', it should run on Linux, right?
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39842A00.B22F6C1F@student.ethz.ch>
Date: Sun, 30 Jul 2000 15:13:36 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Roman Zippel <zippel@fh-brandenburg.de>,
        Linux/PPC on APUS <linux-apus-devel@lists.sourceforge.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bogus dmasound.o module (was: Re: 2.4.0-test4 success (Re: affs))
References: <Pine.LNX.4.10.10007291437400.1201-100000@cassiopeia.home>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> > 'make modules_install' tries to install dmasound.o (which doesn't exist
> > anymore) instead of dmasound_paula.o and dmasound_core.o
>
> Does this help? IIRC, I have it in my tree since a while, but I forgot about
> it.

Yes it helps, but the dmasound_* modules get installed in misc, not sound - is
that intended?


Michel


--
Intel: where Quality is job number 0.9998782345!
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

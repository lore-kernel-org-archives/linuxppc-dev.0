Message-Id: <v04003a03b474c17e6e53@[216.81.20.25]>
In-Reply-To: 
 <Pine.LNX.3.96.991208172006.11794D-100000@deepspace.mklinux.org>
References: <v04003a02b47493b8bdac@[216.81.20.25]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 8 Dec 1999 21:45:54 -0600
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
From: Tony Mantler <eek@escape.ca>
Subject: Re: Non-OF Ports (was Re: Need developer to help move JDK ppc
 port forward)
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:24 PM -0600 12/8/99, David A. Gatwood wrote:
[...]
>Heheh.  Stay tuned on the 5200.  My finals are over, and I have a few
>things left to do before I'm free for a while.  I've tracked down more
>information about the booting failures and I've started moving through the
>MkLinux code from the early stuff by checkout date trying to figure out
>exactly where it stopped starting to boot.  As soon as I've figured out
>what's wrong there, it should be trivial to get these machines at least
>partially working.
>
>We (MkLinux) already have an interrupt handler for them that I think is
>mostly right, along with hooks for the hardware addresses of every
>significant chip on the motherboards (there aren't very many), so the
>remainder of the porting is details.  I have a 6214 in my dorm room that I
>want to get off the floor, hence porting should go much faster now.  ;-)

The interrupt handling in
<http://www.mklinux.org/cgi-bin/cvsweb/osfmk/src/mach_kernel/ppc/POWERMAC/interr
upt_performa.c?rev=1.6> looks like what I was hoping I wouldn't have to
write. Somehow I can't picture apple using a 'check every IRQ source on
interrupt' method for routing between the 68k and PPC interrupt styles, but
I guess I wouldn't put it past them. (It also leaves the question of where
does the NMI go)

Beyond that, Linux/Mac68k has plenty of code for the Q630 that can be
recycled for my 5200.

But before that, I'd really like to more fully understand the Capella chip
in both it's cache controlling and interrupt functions, so I can support it
properly.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

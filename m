Date: Wed, 8 Dec 1999 17:24:18 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Tony Mantler <eek@escape.ca>
cc: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Non-OF Ports (was Re: Need developer to help move JDK ppc port forward)
In-Reply-To: <v04003a02b47493b8bdac@[216.81.20.25]>
Message-ID: <Pine.LNX.3.96.991208172006.11794D-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 8 Dec 1999, Tony Mantler wrote:

> At 4:12 PM -0600 12/8/99, Takashi Oe wrote:
> >On Wed, 8 Dec 1999, Kevin_Hendricks wrote:
> >[...I'm sorry to hear about JDK port...]
> >> Also, if anyone needs a 40 something year old former PDP-8 and PDP-11
> >>programmer
> >> with time on his hands to help out a *true* Open Source project, let me
> >>know...
> >
> >Do you still have 8100 with you?  If so, porting Linux/PPC to your machine
> >may be a project for you.  Now that BootX can boot MkLinux, everything
> >there is open source (finally).
> 
> Speaking of Non-OF machines...
> 
> I was thinking it would help porting (in my case, to my 5200, which I
> unfortunatley haven't had much chance to work on lately) if BootX were able
> to construct a fake OF device tree in the absence of a real one.
> 
> I'm not sure exactly what the structure should be, but the kernel shoudn't
> need a whole bunch information as the NuBus style hardware is fairly simple.
> 
> I'd do it myself, but I don't have codewarrior. (Fooey on non-free MacOS
> dev tools) :)

Heheh.  Stay tuned on the 5200.  My finals are over, and I have a few
things left to do before I'm free for a while.  I've tracked down more
information about the booting failures and I've started moving through the
MkLinux code from the early stuff by checkout date trying to figure out
exactly where it stopped starting to boot.  As soon as I've figured out
what's wrong there, it should be trivial to get these machines at least
partially working.

We (MkLinux) already have an interrupt handler for them that I think is
mostly right, along with hooks for the hardware addresses of every
significant chip on the motherboards (there aren't very many), so the
remainder of the porting is details.  I have a 6214 in my dorm room that I
want to get off the floor, hence porting should go much faster now.  ;-)


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Thu, 14 Jan 1999 14:18:13 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Michael Schmitz <schmitzm@uclink4.berkeley.edu>
cc: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <v03020900b2c32a566a02@[128.32.144.85]>
Message-ID: <Pine.LNX.3.96.990114141525.17757A-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Jan 1999, Michael Schmitz wrote:

> The CUDA hangs off VIA1 in the m68k machines. If this machine is just a
> 040 Mac with a PPC glued on top, the m68k code should do.

Basically, yeah.


> VIA1 and VIA2 are at fairly constant base addresses throughout the
> m68k series. But Apple might have played some tricks on us again :-(

'course I don't even know the base address for the IO space, but I'm
gathering it's the same as the PDMs, and I vaguely remember reading that
somewhere.  Right now, the question basically boils down to the display
going off (or black or something) when interrupts are enabled.  If we can
get past that, it should be mostly smooth sailing.  We'll have to have
base addresses for the IDE hardware, but I'd expect it to share that with
the NuBus PowerBooks....  Apple's addresses seem to be very similar
between the PDMs, the PERFORMA class, and the POWERBOOK class (NuBus).


David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624

-----BEGIN GEEK CODE BLOCK-----
Version 3.1
GCS/CC/FA/H/L/MC/M/MU/PA/TW d-@ s:>- a-- C++ ++>$ UBLAS*++ ++>$
P+?>$ L++ +>$ !E--- W++ +>$ N++(++ +)>++ +$ !o? K-? !w--- !O
M++>$ !V-- PS+>$ !PE- Y+>$ PGP+>$ t++ +>$ 5+>++ ++$ !X- !R tv+>$
b++>$ !DI !D- G++(++ +)>$ e>++ ++ h--! r--- !y-

------END GEEK CODE BLOCK------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

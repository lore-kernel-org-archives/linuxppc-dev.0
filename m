Message-Id: <v04003a05b8e0b64c8a51@[24.70.162.28]>
In-Reply-To: <20020415104146.54193.qmail@web11002.mail.yahoo.com>
References: <v04003a04b8e03cacee74@[24.70.162.28]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 15 Apr 2002 12:32:35 -0500
To: Dan Bethe <dan_bethe@yahoo.com>, linuxppc-dev@lists.linuxppc.org
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: 9600 maturity?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:41 AM -0500 4/15/02, Dan Bethe wrote:
>> I've not had too much trouble with my 9600/200mp. I haven't used it much
>> since early 2.4, mind you (got enough other unix boxes on my desktop), but
>
>Not too much?  Does that mean you can beat the crap out of all subsystems 24/7
>with no hardware failure?  :)  Like a 'make -j20' on the kernel src with
>several concurrent 'badblocks'?

I think I could crash it by trying to use 'hdparm' on the IDE-connected
drives, but I don't recall anything else that would make it puke.

Most of the fuss I ran into was just getting a kernel with the right
patches to talk to all the Promise card, and figuring out why the heck SMP
wouldn't work.


>> I haven't had much trouble with the PCI. I'm running a Promise Ultra66 and
>
>Not much?  Does that mean it was reliable, or just sticky to configure?

Well, when I was linuxing my 9600, it was around the time of the PCI code
being in a state of a whole lot of flux, trying to handle 3+ busses per
machine and resorting board resources. I think (hope) that work has been
basically finnished and integrated now, so I wouldn't expect nearly as much
trouble now.

Nothing in linux is ever exactly 100% though. I recently had a heck of a
headache trying to get the AC97 sound in my l33t athlon working - had to
hack and patch the kernel to death, and while I eventually got it mostly
working, Quake3 still won't talk to it.


>> I'd definatley pick a 9600 to run linux on over an 8500 - if for no other
>> reason than it having the very cool flip&fold case. 8)
>
>Yeah that's a chief factor.  Does the flip&fold give easy access to RAM and
>cache, unlike the 8500?  Do you happen to know how the internal cooling
>compares between the 8500 and 9600?  I have several internal hard drives and
>cards.
[...]

Yes! The case gives amazingly easy access to all the internal guts. The PCI
cards, drives and all can be accessed by removing the left side of the
case, which pops off with just one latch. The ram and cpu can be accessed
by further unplugging the power cord, and lifting up on the very convinient
translucent blue handle to fold the drivecage/powersupply out of the way.

Replacing the ram on an 8100 (which I had to do at one point. Never tried
in an 8500, but I understand it's very similar) is like trying to do a root
canal from the butt-end in comparison.

The cooling is rather sophisticated and intricate. The air is channeled in
such a way that it flows in from around the edges of the motherboard, and
also in from around the front of the drive bays. The air enters from the
bottom, rear, and lower-right side of the case, and exits in the back
(powersupply) and in the lower-left (removable panel) by the encouragement
of two temperature-controlled 120mm fans.

The air temperature in this room can exceed 30c at times, and I've never
had a thermal-related failure in the system. Even with dual-cpus and a
bunch of drives it runs much cooler than my SGI Indigo2 (R10k@195,
MaxIMPACT gfx. it eats plenty of power). That said, the cooling system
should be easily capable of sucking out the whole 390 watts (or 560 watts
for 300/350MHz) of heat that the powersupply can deliver.


Anyways, some things you might consider adding to a 9600 should you pick
one up:

#1: Ram. With 12 dimm slots, it can take a gig and a half of 5 volt 168-pin
FPM or EDO, though maxing it out might be expensive. Remember to install in
matched pairs to take advantage of interleaving.

#2: Faster HD controller. QLogic cards are pretty sweet, Adaptec cards will
do in a pinch, and Promise cards seem to work nice if you've got a taste
for cheap IDE gigs. The PCI bus has a measured max throughput of 80MB/s per
bus, so you might as well put it to good use.

#3: Newer video. Radeon7000 PCI is a good choice. This obviously isn't a
factor when the system is to be used as a server though.


All in all, you should be very happy with your new 9600 in linux.

Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

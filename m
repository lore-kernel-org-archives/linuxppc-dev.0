Date: Mon, 15 Apr 2002 21:14:16 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 9600 maturity?
To: dan_bethe@yahoo.com
Cc: nicoya@apia.dhs.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04003a05b8e0b64c8a51@[24.70.162.28]>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16xBvj-000073-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all,

On  15 Apr, this message from Tony 'Nicoya' Mantler echoed through cyberspace:
>
> At 5:41 AM -0500 4/15/02, Dan Bethe wrote:
>>> I've not had too much trouble with my 9600/200mp. I haven't used it much
>>> since early 2.4, mind you (got enough other unix boxes on my desktop), but
>>
>>Not too much?  Does that mean you can beat the crap out of all subsystems 24/7
>>with no hardware failure?  :)  Like a 'make -j20' on the kernel src with
>>several concurrent 'badblocks'?
>
> I think I could crash it by trying to use 'hdparm' on the IDE-connected
> drives, but I don't recall anything else that would make it puke.

Yeah, hdparm -I crashed my 7600 with Promise too, at one time at least.
Didn't use it recently, though, since I know what's on the bus ;-)

> Most of the fuss I ran into was just getting a kernel with the right
> patches to talk to all the Promise card, and figuring out why the heck SMP
> wouldn't work.

Both problems are resolved for 2.4 kernels.

>>> I haven't had much trouble with the PCI. I'm running a Promise Ultra66 and
>>
>>Not much?  Does that mean it was reliable, or just sticky to configure?
>
> Well, when I was linuxing my 9600, it was around the time of the PCI code
> being in a state of a whole lot of flux, trying to handle 3+ busses per
> machine and resorting board resources. I think (hope) that work has been
> basically finnished and integrated now, so I wouldn't expect nearly as much
> trouble now.

No, 2.4 kernels should have solid PCI even in the presence of multiple
host bridges (which was the problem on the dual-bandit 9x00). The only
potentially remaining problem could be access to IO space on the second
bus. Ben, can you comment?

> Anyways, some things you might consider adding to a 9600 should you pick
> one up:
>
> #1: Ram. With 12 dimm slots, it can take a gig and a half of 5 volt 168-pin
> FPM or EDO, though maxing it out might be expensive. Remember to install in
> matched pairs to take advantage of interleaving.

To be sure, I have a tool on my homepage that checks the
hammerhead (memory controler) configuration for interleaving.

> #2: Faster HD controller. QLogic cards are pretty sweet, Adaptec cards will
> do in a pinch, and Promise cards seem to work nice if you've got a taste
> for cheap IDE gigs. The PCI bus has a measured max throughput of 80MB/s per
> bus, so you might as well put it to good use.

To take into account here: bootability. If you need a bootable
additional controler, than that limits your choices. Promise' are not
bootable; but there apparently is a MacOS version from some OEM that has
an OF ROM instead of the PC BIOS ROM. Don't know if it's
Linux-supported, though.

> #3: Newer video. Radeon7000 PCI is a good choice. This obviously isn't a
> factor when the system is to be used as a server though.

Yeah, according to all reports, the original IMS TwinTurbo cards are
problematic.

Chees

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

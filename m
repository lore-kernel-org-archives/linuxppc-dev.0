Message-Id: <200012052129.WAA00743@piglet.grunz.lu>
Date: Tue, 5 Dec 2000 22:29:15 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 3COM 3c905c again
To: jingai@shell.faradic.net
cc: debian-powerpc@lists.debian.org, nicoya@apia.dhs.org,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200012041511.eB4FB6P19204@shell.faradic.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On   4 Dec, this message from Jonathan Lane echoed through cyberspace:
>> >I'd also like to know why the last four PCI slots don't work properly,
>> >although it appears it's not incredibly important now, unless X doesn't
>> >work...
>>
>> I think there's some PCI bogosity in the standard 2.2 kernels when it comes
>> to PCI-PCI bridges. I've had fairly good luck with 2.2 with a PCI patchset

For PCI-to-PCI bridges, it's only regarding IRQs. For multiple host
bridges (like 9x00 machines), it's more complex.

> This was the problem.  I moved the NIC to slot 2, and moved my video board
> to slot 4.  Everything works fine now.  The actual problem with packets
> not making it to the other machine had to do with my homemade cable (works
> over 10BT, but not 100BT... probably either due to length and/or quality).

Cables for 100BT need to be _very_ good quality, if you go by handmade
standards. I've had some bad luck with homemade cables as well; they
tested perfectly fine with a 10BaseT tester, but didn't work with
100BaseT.

> Also, if you or anyone else can ever recall the source for the PCI patch,
> I'd appreciate it.  Wonder why it hasn't been rolled into the 2.2 kernels
> yet, though...?

The PCI patch Tony talked about was probably mine, and can be found
here:

http://www.cpu.lu/~mlan/linux/dev/pci.html

The reason it's not in 2.2 is that for one, it's not good enough for
2.2, plus it is sometimes extremely hard to get patches into the more
official kernels... that can be frustrating, at times. Which eats up
some of the motivation to work harder...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3D77EE69.8F0A942A@koffie.nl>
Date: Fri, 06 Sep 2002 01:39:38 +0200
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: mlan@cpu.lu
Cc: benh@kernel.crashing.org, jason@openinformatics.com,
	eblanton@cs.ohiou.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Shift keycodes on the iBook
References: <E17mpjY-0000DD-00@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> On   3 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:
> >>> The interesting thing is that was what was believed for years about
> >>> the locking capslock key as well...
> >>
> >>Ah, but that depends on the specific model of keyboard. At least some of
> >>Apple's ADB keyboards _do_ indead have a mechanical capslock.
> >>
> >>I don't know for USB keyboards, but obviously the PowerBook keyboards
> >>have a regular (non-locking) key as capslock. Whether the lock is done
> >>in the ADB driver or in the keyboard controller, I don't know...
> >
> > Actually, the lock itself isn't, but the keycode sent by the PMU behave
> > like a HW lock (and the LED is driven that way too).
> >
> > In both cases, there may be ways to instruct the PMU to behave differently
> > but I don't know about them.
>
> Anybody up for sucking the PMU firmware out of the little beast and
> reverse-engineering it? Might be a fun project :-))

There's a little program for doing the "sucking" part of this available on
my page at penguinppc.org;  Apple was nice enough to include some commands
in the CPU<->PMU interface language for reading any part of the PMU memory.

The PMU is a Mitsubishi MCU; afaik, it's a M30624FGMGP, which is a member of the
M16C/62 family.  Mitsubishi's documentation pages have been much improved
lately; you can actually find the pdf's you need now :)

Reverse engineering something as big as this is quite a bit of work, though;
especially if you don't know which of the 88 i/o lines on the chip are
connected where ;)


Cheers,

Segher

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Mon, 3 Nov 2003 22:30:11 +0100 (CET)
From: Mich Lanners <mlan@cpu.lu>
Reply-To: Mich Lanners <mlan@cpu.lu>
Subject: Re: IRQS on 6 Slot Macs
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Message-Id: <E1AGmH5-0000CV-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   3 Nov, this message from Geert Uytterhoeven echoed through
cyberspace:
>> > I don't know what's up with the DRM not liking your interrupt. I
>> > can answer for the sharing of USB, symbios and firewire interrupts:
>> > all 3 slots share one interrupt because of bad motherboard design
>> > :) Basicallly, what they did when designing that machine was to use
>> > a standard powersurge design with 3 slots and replace one of them
>> > with a PCI<->PCI bridge. Since they didn't "know" how to get more
>> > interrupt lines out of Grand Central, they just also stuffed all
>> > interrupt lines together for those 4 slots (I'm pretty sure GC do
>
> Tsss... They could at least have `swizzled' the lines...

Sure, but it's indeed totally not understandable why they didn't use the
other lines on GrandCentral, since the 9500/9600 design includes six PCI
slots with each a dedicated IRQ line. Weird...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

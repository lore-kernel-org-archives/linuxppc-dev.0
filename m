Message-Id: <200008291737.TAA00677@piglet.grunz.lu>
Date: Tue, 29 Aug 2000 19:37:07 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: asm in OF?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Does anybody know how to embed machine code into an OF script (into
nvramrc, that is)? I suppose OF doesn't have an assembler built-in, so
machine code would be the only option.

For the curious, what I'm trying to do is get my box (7600 upgraded with
G3/300) to boot again from my IBM disk on the MESH SCSI bus. Right now,
it does that only if I run the G3 below 200 MHz, or the bus speed around
40 MHz. Anything faster, and I can't access that disk on the MESH bus.
The external (53c96) is o, however... but much slower.

So, I wanted to check whether using the L1 cache throttling mechanism to
slow down the CPU during boot would help anything... I can then release
the brake later, once Linux is up (which doesn't have any problem with
the MESH).

To use the cache throttling, I need to access the ICTC register, but
there is no OF method to do that. So I would have to code one myself...

Since it seems the OF MESH driver is at fault, I could try to patch that
one, but that seems like an even harder task...

I could also try and copy other special register access methods (like
hid0@ and hid0!) if I knew how...

Thanks for any hints you can provide!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200006070557.HAA01163@piglet.grunz.lu>
Date: Wed, 7 Jun 2000 07:57:28 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2940UW & 2.4.0-test-ac7 PCI probs
To: toa@pop.agri.ch
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <393CF541.4E4D88B7@pop.agri.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Andreas,

On   6 Jun, this message from Andreas Tobler echoed through cyberspace:
>> So if the SCSI driver actually uses the IO region, it will most
>> certainly not work....
>
> How do I find that out?

RTFS ;-)

> Below it says I/O ports unassigned and it works. (2399p9)

So it is probably using the memory region. A lot of those chips support
two different views on their register file: via an IO port window and
via a memory(-mapped) region. But the functionality available is the
same on both...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Mon, 27 Jan 2003 23:14:17 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Info on IO vs. Memory mapped PCI configuration ...
To: vroopcha@mcw.edu
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.44.0301271152170.265-100000@kaiso.biophysics.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E18dHWJ-00008i-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  27 Jan, this message from vinai echoed through cyberspace:
> I am just getting into some driver programming for my work.  I read a
> bit of the PCI System Architecture book, and it talked about one of the
> main ways x86 vs the PPC did PCI configuration was through IO vs memory
> space.

Configration? That's inherently platform-dependant. The host bridge
arranges for _some_ way of configuration space access to be available.
_You_ need to know _how_ you access it from the bridge docs.

It happens that PowerPC lacks the seperate address space that is called
'IO' on i386. So yes, everything is memory-mapped on PowerPC, be it
PCI's memory space (big fat mapping often mapped 1:1), IO space (smaller
mapping) or configuration space (mapped in the host bridge's memory
space).

>  Is there an on-line reference somewhere that talks about these
> ideas or concept in more detail?

Not much that I know of... Try Intel or PCI SIG.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

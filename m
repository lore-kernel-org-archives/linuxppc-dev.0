Date: Thu, 22 Jul 1999 10:14:24 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: VALETTE Eric <valette@crf.canon.fr>
cc: mmporter@home.com, jpeters@phx.mcd.mot.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Is the vger 2.2 kernel branch dead
In-Reply-To: <m117Djg-0000WZC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.4.10.9907221012590.18625-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 22 Jul 1999, VALETTE Eric wrote:
> >>>>> "Matt" == Matt Porter <mmporter@home.com> writes:
> 
> Matt> On Mon, 19 Jul 1999, Johnnie Peters wrote:
> 
> Matt> I was being facetious.  Honestly, somebody is feeding me a major line of
> Matt> crap.  Cort claims to get no patches from Motorola, yet Johnnie claims to
> Matt> be sending them in.  Since my stuff is in Johnnie's repository, it's a
> Matt> problem for me.  Hopefully, this time things start going in cause if
> Matt> not we'll have to find another route.
> 
> I was thinking Cort may be on vacation... If this is the case, It's bad

AFAIK Cort is not on vacation. He checks in patches at vger on a daily base.

> it has not been announced. Nevertheless, once again, the lack of transparency
> for patch handling is *really* annoying...
> 
> I understand patches can be rejected. At least I would like to know why...

Just saw this:

CVSROOT:        /vger/u4/cvs
Module name:    linux
Branch:         linux_2_2
Changes by:     cort@vger.rutgers.edu   99/07/21 21:49:46

Modified files:
        arch/ppc       : defconfig 
        arch/ppc/boot  : Makefile misc.c 
        arch/ppc/kernel: i8259.c irq.c prep_pci.c prep_setup.c smp.c 

Log message:
        Changes for Moto SMP boards from Johnnie Peters

CVSROOT:        /vger/u4/cvs
Module name:    linux
Branch:         linux_2_2
Changes by:     cort@vger.rutgers.edu   99/07/21 21:52:26

Modified files:
        include/asm-ppc: keyboard.h 

Log message:
        More MTX changes from Johnnie

CVSROOT:        /vger/u4/cvs
Module name:    linux
Branch:         linux_2_2
Changes by:     cort@vger.rutgers.edu   99/07/21 21:56:57

Modified files:
        .              : CREDITS 

	Log message:
	        Add Johnnie

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

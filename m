Date: Mon, 16 Aug 1999 09:16:47 +1000
Message-Id: <199908152316.JAA02196@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Jes.Sorensen@cern.ch
CC: dgatwood@mvista.com, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
In-reply-to: <d3so5mdyta.fsf@lxp03.cern.ch> (message from Jes Sorensen on 14
	Aug 1999 20:03:45 +0200)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.96.990813143741.27557B-100000@mvista.com> <d3so5mdyta.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jes Sorensen <Jes.Sorensen@cern.ch> wrote:

> Defininf a C function with the name of a PPC specific assembler
> function is pretty stupid. To the best of my knowledge wmb() is the
> generic name for the thing you are looking for.

Not exactly, in fact iobarrier() is probably better.

The eieio instruction has two separate effects:

1. as a write barrier for writes to cacheable memory (hence wmb)

2. as a read/write barrier for reads and writes to non-cacheable
   memory (hence iobarrier)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

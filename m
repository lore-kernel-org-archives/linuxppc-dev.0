Date: Sun, 15 Aug 1999 17:29:12 -0700
From: Richard Henderson <rth@cygnus.com>
To: Paul.Mackerras@cs.anu.edu.au
Cc: Jes.Sorensen@cern.ch, dgatwood@mvista.com,
        Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Message-ID: <19990815172912.A13394@cygnus.com>
References: <Pine.LNX.3.96.990813143741.27557B-100000@mvista.com> <d3so5mdyta.fsf@lxp03.cern.ch> <199908152316.JAA02196@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908152316.JAA02196@tango.anu.edu.au>; from Paul Mackerras on Mon, Aug 16, 1999 at 09:16:47AM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 16, 1999 at 09:16:47AM +1000, Paul Mackerras wrote:
> The eieio instruction has two separate effects:
> 
> 1. as a write barrier for writes to cacheable memory (hence wmb)
> 
> 2. as a read/write barrier for reads and writes to non-cacheable
>    memory (hence iobarrier)

Ah.  The Alpha wmb instruction does _not_ have this second effect.


r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

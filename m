Date: Sat, 14 Aug 1999 14:39:18 -0700
From: Richard Henderson <rth@cygnus.com>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
Cc: "David A. Gatwood" <dgatwood@mvista.com>, Paul.Mackerras@cs.anu.edu.au,
        Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Message-ID: <19990814143918.A11841@cygnus.com>
References: <Pine.LNX.3.96.990813143741.27557B-100000@mvista.com> <d3so5mdyta.fsf@lxp03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d3so5mdyta.fsf@lxp03.cern.ch>; from Jes Sorensen on Sat, Aug 14, 1999 at 08:03:45PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 14, 1999 at 08:03:45PM +0200, Jes Sorensen wrote:
> Defininf a C function with the name of a PPC specific assembler
> function is pretty stupid. To the best of my knowledge wmb() is the
> generic name for the thing you are looking for.

Keep in mind that wmb is the name of an Alpha specific assembler insn.
Blame Linus.  ;-)


r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

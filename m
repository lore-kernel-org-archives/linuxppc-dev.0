Date: Wed, 11 Aug 1999 21:40:49 -0700
From: Richard Henderson <rth@cygnus.com>
To: Paul.Mackerras@cs.anu.edu.au
Cc: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Message-ID: <19990811214049.A14692@cygnus.com>
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <19990811003805.A11890@cygnus.com> <199908120017.KAA25043@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908120017.KAA25043@tango.anu.edu.au>; from Paul Mackerras on Thu, Aug 12, 1999 at 10:17:34AM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 12, 1999 at 10:17:34AM +1000, Paul Mackerras wrote:
> Sync and eieio are different in that for sync, the cpu actually stops
> and waits for all memory accesses to complete, whereas for eieio the
> cpu doesn't have to stop and wait for anything.  Do alpha's mb and wmb
> work the same way?

Yes.  (Except for EV4, in which wmb == mb, but we don't care about that.)

> My position is that if you can provide the ordering at essentially
> zero cost, then it is an advantage to have it since more drivers will
> work that way.

But it isn't zero cost.  It's not high cost, but that's not the same thing.


r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Thu, 12 Aug 1999 09:52:31 +1000
Message-Id: <199908112352.JAA25021@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Jes.Sorensen@cern.ch
CC: Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu, rth@cygnus.com
In-reply-to: <d34si6kcge.fsf@lxp03.cern.ch> (message from Jes Sorensen on 11
	Aug 1999 09:23:29 +0200)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jes Sorensen <Jes.Sorensen@cern.ch> wrote:

> I will have to disagree with you on this one, I consider the PPC
> implementation to be very broken in this regard.

"Very broken" - because drivers work and there is no measurable
performance impact?? !!! ??

The only possible argument for *not* having the eieio in readl/writel
is that it hurts performance (actually and measurably, not just
potentially).

Paul.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Thu, 12 Aug 1999 15:00:46 +1000
Message-Id: <199908120500.PAA30022@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: rth@cygnus.com
CC: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
In-reply-to: <19990811214049.A14692@cygnus.com> (message from Richard
	Henderson on Wed, 11 Aug 1999 21:40:49 -0700)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <19990811003805.A11890@cygnus.com> <199908120017.KAA25043@tango.anu.edu.au> <19990811214049.A14692@cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Richard Henderson <rth@cygnus.com> wrote:

> But it isn't zero cost.  It's not high cost, but that's not the same
> thing.

Show us the numbers?

I'm starting to sound like Larry McVoy, I know. :-)

The measurements I did showed no measurable difference in performance
for copying stuff around a framebuffer on PPC (Richard, I guess you
may not have seen that post).  As far as PPC is concerned, I am
unwilling to break drivers for the sake of an infinitesimal
performance gain.  I don't believe the frame-buffer guys will actually
see any measurable improvement in performance from taking out the
eieio from readl/writel on PPC.

Of course, it may be different on alpha, and I would be very
interested to know how big the effect is there.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

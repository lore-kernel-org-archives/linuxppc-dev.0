From: acmay@acmay.homeip.net
Date: Wed, 5 Sep 2001 09:25:36 -0700
To: jpeters@mvista.com
Cc: andrew may <acmay@acmay.homeip.net>,
	John Tyner <jtyner@cs.ucr.edu>, linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405 enet changes (fwd)
Message-ID: <20010905092536.C621@sink.san.rr.com>
References: <Pine.LNX.4.30.0109031513110.21186-200000@hill.cs.ucr.edu> <3B9557CA.D76C70E2@mvista.com> <20010904152608.B14548@ecam.san.rr.com> <3B9632EB.51904875@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B9632EB.51904875@mvista.com>; from jpeters@mvista.com on Wed, Sep 05, 2001 at 07:12:59AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 05, 2001 at 07:12:59AM -0700, jpeters@mvista.com wrote:
> In addition, many of the embedded system boards around are still
> not what you would call blindingly fast.  The 405 chips I had would
> do a maximum of 200 Mhz and the additional software cache
> coherency code made it look a lot slower.  In a situation like
> this anything to reduce instruction count speeds up execution.
> Especially if it is code that runs at interrupt level.

So did you chose the vars that were to be static and the ones in
dev->priv for speed? If so it would be nice to see how you decided
which ones when where.

I would think that it would be best to keep all the vars as close
together in mem as possible, to keep them on the fewest number of
cache-lines. By splitting them between two sections I would think
it hurts more than it helps.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

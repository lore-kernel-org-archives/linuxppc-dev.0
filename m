Date: Fri, 14 Nov 2003 08:57:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
Message-ID: <20031114155735.GC13003@ip68-0-152-218.tc.ph.cox.net>
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com> <3FB01392.60500@g-house.de> <20031110175740.A32176@forte.austin.ibm.com> <3FB02C85.6090400@g-house.de> <20031111153658.GH8584@ip68-0-152-218.tc.ph.cox.net> <3FB2D757.1010304@g-house.de> <20031113174745.GA11560@ip68-0-152-218.tc.ph.cox.net> <3FB41A14.3040108@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FB41A14.3040108@g-house.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 14, 2003 at 12:56:04AM +0100, Christian Kujau wrote:

> Tom Rini wrote:
> >
> >Ok, it's been a while since anyone tried KGDB it seems.  The following
> >is an untested (yet) patch that makes it compile and maybe work:
> >
> >===== arch/ppc/Kconfig 1.46 vs edited =====
> [...]
>
>
> ok, i could have done the stuff in Kconfig though, next time i will do
> so at once. well, compiling wnt fine on the ppc now (my i386 cross
> compile is still pending), but the things with the serial console will
> have to wait now. hm, i'm not online at the weekend, so don't expect
> much results these days. thank you very much for checking back to this
> issue, i (and hopefully some other PreP people out there) really
> appreciate this.
>
> Christian.
>
> PS: oh, will this patch reach mainline anytime soon?

Probably once Andrew Morton takes over again, at least some parts of the
patch will go in, an the rest possibly in 2.6.1, depending on how much
he wants to let arches sync up.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

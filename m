Date: Fri, 21 Nov 2003 10:54:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
Message-ID: <20031121175400.GB9696@ip68-0-152-218.tc.ph.cox.net>
References: <3FB01392.60500@g-house.de> <20031110175740.A32176@forte.austin.ibm.com> <3FB02C85.6090400@g-house.de> <20031111153658.GH8584@ip68-0-152-218.tc.ph.cox.net> <3FB2D757.1010304@g-house.de> <20031113174745.GA11560@ip68-0-152-218.tc.ph.cox.net> <3FB41A14.3040108@g-house.de> <3FBA11AC.8090408@g-house.de> <3FBA2959.80609@g-house.de> <3FBE2E80.3080805@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FBE2E80.3080805@g-house.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 21, 2003 at 04:25:52PM +0100, Christian Kujau wrote:

> hi again (and sorry to contact you directly, Tom),
>
> i did not make it with kgdb, but rather compiled kernels over and over
> again this week. my gcc-3.3.2 won't compile on a faster i386, so
> crosscompiling was not an option :-(
>
> i went down to 2.5.56 and found that even this kernel has the same
> symptoms. in short: upon using "tulip", the machine freezes, "3c59x" is
> loaded, but not working. (no routing).
>
> i went even down to 2.5.30 to find out, that this kernel is *working*!
> both tulip and 3c59x get loaded and are working. i did not test long,
> don't know if it will freeze after a day or so, but i think not, as the
> described freezes with newer kernel occur instantly.
>
> the thing is, 2.5.31 ist not compiling, nor is 2.5.3x, except this very
> 2.5.30. same config, same compiler. 2.5.30 compile over and over again,
> newer kernels (2.5.31...up to 2.5.46) *do not compile*. so it's pretty
> hard to find out *when* the symptoms occur, to dig into this very patch
> and finally find out *why*.
>
> i *hope* 2.5.31 or at least 2.5.32 is the bad one. i am curently looking
> through the 2.5.31 patch and sorted out ppc-related stuff, to make it
> compile, then shuffle a few bits back in so, that it will compile and i
> hopefully get my freeze. yes, you can see that this kind of working is
> rather...er..crap. but i can't do better at the moment :-(

I'd suggest talking to:
NETWORK DEVICE DRIVERS
P:      Andrew Morton
M:      akpm@digeo.com
P:      Jeff Garzik
M:      jgarzik@pobox.com
L:      linux-net@vger.kernel.org

specifically, as they probably know what changed in terms of network
code in between 2.5.30 and 2.5.46 and might even be able to give you
diffs to apply to 2.6.0-testCurrent.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 4 Sep 2001 19:39:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: andrew may <acmay@acmay.homeip.net>
Cc: Dan Malek <dan@mvista.com>, John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405 enet changes (fwd)
Message-ID: <20010904193922.O11530@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.LNX.4.30.0109031513110.21186-200000@hill.cs.ucr.edu> <3B9557CA.D76C70E2@mvista.com> <20010904152608.B14548@ecam.san.rr.com> <3B956C82.D2D7E9C6@mvista.com> <20010904180915.E14548@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010904180915.E14548@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 04, 2001 at 06:09:15PM -0700, andrew may wrote:
> > Yeah, all of the linux version stuff.  It is nice to get patches against
> > the current 2_4 or 2_4_devel that are known to be tested and working.
>
> Well the linux version stuff was our compromise for not being able to test
> with the new 2_4_devel kernel since we can't build it. I will be happy to
> see the ifdef's go away. I have to deal with them my other kenerl modules.

Well, I've heard rumors about it booting, and even to some degree working,
depending on HW.  When'd did you last try? :)  Do you get to the
Linux/PPC load: prompt still?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

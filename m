Subject: Re: MPC5xxx code issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Wolfgang Denk <wd@denx.de>, Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net>
References: <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1069114889.7170.50.camel@gaston>
Mime-Version: 1.0
Date: Tue, 18 Nov 2003 11:21:30 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> drivers/ide/ppc/mpc5xxx_ide.c, etc (I'm not actually sure if Alan
> reviews drivers, or would given that he's spending less time on Linux
> right now)

Well, I wrote this one, so it should be fairly ok as long as it
was fixed since the last time I had a 5200 at hand, the driver
didn't work (the bestcomm tasks weren't doing their job properly)

But maybe the one you have there is PIO only ? In which case
it will just work.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

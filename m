Date: Thu, 18 Dec 2003 09:13:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: Robin Gilks <robin.gilks@tait.co.nz>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: wdt_mpc8xx documentation
Message-ID: <20031218161356.GA28108@stop.crashing.org>
References: <3FE12DCD.10609@tait.co.nz> <1071726766.3533.11.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1071726766.3533.11.camel@shiva.eth.saftware.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 18, 2003 at 06:52:46AM +0100, Andreas Oberritter wrote:
> Hi Robin,
>
> Have a look at our driver, which uses the kernel's watchdog api:
> http://cvs.tuxbox.org/cgi-bin/viewcvs.cgi/*checkout*/tuxbox/cdk/Patches/linux-2.4.23-pre6-m8xxwdt.diff?rev=HEAD&content-type=text/plain
>
> It will probably never get into vanilla 2.4 because Marcelo doesn't
> respond to my Emails. However, it is really stable since months...
> What other driver were you talking about?
>
> Tom, would you put this driver into the 2.4 ppc trees if I rediffed it?

Have there been any updates since the last one you sent me?  I've
actually got it in a tree I'm going to get Marcelo to pull from.
Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Sat, 5 Jun 2004 12:22:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Take two of the new serial uart driver.
Message-ID: <20040605192221.GT15195@smtp.west.cox.net>
References: <40BF3206.8030705@intracom.gr> <1086426744.4588.121.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086426744.4588.121.camel@imladris.demon.co.uk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jun 05, 2004 at 10:12:24AM +0100, David Woodhouse wrote:

> On Thu, 2004-06-03 at 17:13 +0300, Pantelis Antoniou wrote:
> > Hi
> >
> > The following patch updates the new CPM1/CPM2 uart driver.
>
> It seems to lose queued characters from the kernel output when userspace
> /dev/console is first opened. Should you drain the FIFO before resetting
> the hardware on open? Or indeed refrain from resetting the hardware if
> you're not actually changing anything?

I haven't seen this problem on 8xx myself.

> This is with console on ttyCPM0 == SMC1. SysRq is also non-functional.

SysRq is fixed in the linuxppc-2.5 tree now.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Subject: Re: [PATCH] Take two of the new serial uart driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40C42D10.5030308@intracom.gr>
References: <40BF3206.8030705@intracom.gr>
	 <1086426744.4588.121.camel@imladris.demon.co.uk>
	 <20040605192221.GT15195@smtp.west.cox.net>
	 <1086472929.4862.12.camel@localhost.localdomain>
	 <40C42337.20209@intracom.gr>
	 <1086597379.29255.13.camel@localhost.localdomain>
	 <40C428AD.8020707@intracom.gr>
	 <1086598392.29255.15.camel@localhost.localdomain>
	 <40C42D10.5030308@intracom.gr>
Content-Type: text/plain
Date: Mon, 07 Jun 2004 10:06:05 +0100
Message-Id: <1086599165.29255.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-07 at 11:53 +0300, Pantelis Antoniou wrote:
> It is mentioned in the manual that you must wait
> two character times for the HW fifo to drain.
> There is no hardware event bit for FIFO empty.
>
> It's just that the udelay call is not really exact.
> So +1 and we're all OK! :)

Ah, OK.

> So did it work now?

It did; thanks.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

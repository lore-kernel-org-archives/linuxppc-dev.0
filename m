Subject: Re: WindRiver PowerQUICC III SBC8560 support.
From: David Woodhouse <dwmw2@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040621232921.GD8561@smtp.west.cox.net>
References: <1087563278.19489.3156.camel@hades.cambridge.redhat.com>
	 <205EB944-C12D-11D8-ACD7-000393DBC2E8@freescale.com>
	 <1087827285.18627.66.camel@hades.cambridge.redhat.com>
	 <20040621232921.GD8561@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1087897386.4520.63.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Tue, 22 Jun 2004 10:43:06 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-21 at 16:29 -0700, Tom Rini wrote:
> That sounds like a bug.

The whole thing's a bug. I'd rather just stop using it, and call
serial_8250_console_init() from setup_arch() instead.

There's no reason why we have to wait for console_init() to start up
consoles.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

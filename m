Date: Mon, 29 Oct 2001 09:57:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	akuster@mvista.com
Subject: Re: linuxppc_2_4_devel on walnut
Message-ID: <20011029095704.A8198@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BDD855B.8D3FC72F@inn.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BDD855B.8D3FC72F@inn.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 29, 2001 at 05:35:39PM +0100, Kenneth Johansson wrote:

> 1. The default configuration don't compile

Can you post a log?

> 2. The ethernet driver gets confused. It reports 10mb and half duplex when it
> really is 100Mb full duplex. And it reports 100Mb full duplex when only 10Mb
> half duplex exist.

Which PHY?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

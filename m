Date: Wed, 15 Jan 2003 15:26:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>
Subject: Re: 2.5 and request_8xxirq
Message-ID: <20030115222619.GA21424@opus.bloom.county>
References: <3E253735.8040300@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E253735.8040300@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jan 15, 2003 at 12:25:57PM +0200, Pantelis Antoniou wrote:

> I'm in the process of porting my board based on a MPC850
> from 2.4 to 2.5 and it appears that request_8xxirq is gone.

request_8xxirq is not yet gone in 2.5, but it will be in 2.4 very shortly
now (IIRC, it has made its way to Marcelo) as there were hopes of trying
to replace it with something more agreeable to Dan Malek as well as
everyone else.
But be warned, if you're going to try and use 2.5 on 8xx, it will not
work without changes to the interrupt handler and some minor MM things.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

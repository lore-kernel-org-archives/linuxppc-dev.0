Date: Thu, 15 Jan 2004 12:36:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibmstb4 fixes
Message-ID: <20040115193619.GF983@stop.crashing.org>
References: <1074028643.1526.42.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1074028643.1526.42.camel@shiva.eth.saftware.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 13, 2004 at 10:17:23PM +0100, Andreas Oberritter wrote:

> Hi Tom,
>
> here are three trivial patches for linuxppc-2.4:
> - two typo fixes for i2c and the ocp definition

Is the first one related to dgibsons latest changes?

> - the ide driver ported to the current ocp api

Thanks.

> Now that linuxppc_2_4_devel seems to be rather dead, would you accept a
> patch that adds the smc91111 network driver to linuxppc-2.4?

I'd rather the smc91111 driver be sent to Jeff Garzik for review so he
can push it into linux-2.4 and offer hints / help to get it into 2.6.

> What is the status of the 405 wdt driver?

I don't know, but Matt Porter might.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

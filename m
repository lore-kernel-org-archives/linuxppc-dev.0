Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56357DDDE2
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 14:42:26 +1000 (EST)
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27-
	"no_irq_chip" error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20090602043819.GA1069@pengutronix.de>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl> <20090528123311.GA3112@pengutronix.de>
	<1243903641.591.19.camel@pasglop>
	<20090602043819.GA1069@pengutronix.de>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 14:42:16 +1000
Message-Id: <1243917736.5308.19.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-06-02 at 06:38 +0200, Wolfram Sang wrote:
> I fully agree that the proper way is using the device tree. I can't recall
> exactly why this wasn't an option to me a year ago, but I assume it had
> something to do with this ugly out-of-tree-driver. I wouldn't really argue
> about this patch, I just thought it might be useful as it seems there are
> people trying to do the same for some reason. Then again, maybe it should be
> skipped, as it makes it easier to not use the proper solution (= device tree)
> :)

Whether the driver is in or out of tree shouldn't affect the device-tree
which represents the -devices- on the system regardless of whether a
driver is in-tree or not.

So while some people might flinch, I don't necessarily object to adding
nodes in the device-trees we ship with the kernel for things for which
we don't have an in-tree driver.

It does mean however that the risk of such nodes containing busted
informations that aren't spotted because nobody has the driver to test
is higher but that's a risk you are taking with out of tree drivers
anyway.

Cheers,
Ben.

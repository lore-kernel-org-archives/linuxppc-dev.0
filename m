Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id ADA4167A6E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 18:52:30 +1100 (EST)
Date: Wed, 9 Mar 2005 08:40:05 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050309074004.GA28306@pegasos>
References: <20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston>
	<20050308122048.GA22866@xyzzy> <20050308121501.GC4556@pegasos>
	<20050308124201.GA5545@pegasos> <20050308164310.GA9891@pegasos>
	<1110321086.13593.284.camel@gaston>
	<20050309071722.GA25622@pegasos> <1110353967.32524.83.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1110353967.32524.83.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Dale Farnsworth <dale@farnsworth.org>, sl@bplan-gmbh.de,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Nicolas DET <det.nicolas@free.fr>, linuxppc-embedd@ozlabs.org
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2005 at 06:39:27PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-09 at 08:17 +0100, Sven Luther wrote:
> 
> > vendor-id             0x11AB (4523)
> > device-id             0x6460 (25696)
> > revision-id           0x3 (3)
> > class-code            0x60000 (393216)
> > subsystem-id          0x0 (0)
> > subsystem-vendor-id   0x0 (0)
> > .vendor-name          "Marvell"
> > .part-number          "MV6436x"
> > .description          "System Controller for PowerPC Processors"
> > .class                "Bridge Device"
> > .subclass             "Host/PCI"
> > devsel-speed          0x0 (0)
> > min-grant             0x0 (0)
> > max-latency           0x0 (0)
> > name                  "host"
> > reg                   0:0
> > assigned-addresses
> 
> Ok, teach them the interest in having a "model" and "compatible"
> property in them for their next version...

You mean a model in /pci/host, ok, i can add that.

> > In the /pci/host node, i also have :
> > 
> > model                 "Pegasos2"
> > 
> > In the root node, and in the new OF, we even have a /discovery2/port@1 or
> > something such, but it is unreleased yet.
> 
> Ugh ? What is that supposed to be ?

As opposed to /ethernet/port1 as it is currently.

> If it's an ethernet port, it should be called "ethernet".

In fact, we already did it, it is /discovery2/ethernet@1, which should make
yaboot happy, i think. Not released though.

> > The thing is not that there is no info, just to chose which info is best.
> > 
> > Christoph suggested to not do that though, but use the normal pci stuff and
> > match on the host pci id with pci_dev_present. This is what i was thinking of
> > doing too, and may be more logical, no ? 
> 
> Yah, if there is no meaningful OF name, then probably.

Well, if there is both, what is the best way to do this ? 

Friendly,

Sven Luther

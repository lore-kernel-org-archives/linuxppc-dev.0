Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02AAC67A72
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 18:44:15 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050309071722.GA25622@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston> <20050308122048.GA22866@xyzzy>
	<20050308121501.GC4556@pegasos> <20050308124201.GA5545@pegasos>
	<20050308164310.GA9891@pegasos> <1110321086.13593.284.camel@gaston>
	<20050309071722.GA25622@pegasos>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 18:39:27 +1100
Message-Id: <1110353967.32524.83.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dale@farnsworth.org>, sl@bplan-gmbh.de,
	linuxppc-embedd@ozlabs.org, Nicolas DET <det.nicolas@free.fr>
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-03-09 at 08:17 +0100, Sven Luther wrote:

> vendor-id             0x11AB (4523)
> device-id             0x6460 (25696)
> revision-id           0x3 (3)
> class-code            0x60000 (393216)
> subsystem-id          0x0 (0)
> subsystem-vendor-id   0x0 (0)
> .vendor-name          "Marvell"
> .part-number          "MV6436x"
> .description          "System Controller for PowerPC Processors"
> .class                "Bridge Device"
> .subclass             "Host/PCI"
> devsel-speed          0x0 (0)
> min-grant             0x0 (0)
> max-latency           0x0 (0)
> name                  "host"
> reg                   0:0
> assigned-addresses

Ok, teach them the interest in having a "model" and "compatible"
property in them for their next version...

> In the /pci/host node, i also have :
> 
> model                 "Pegasos2"
> 
> In the root node, and in the new OF, we even have a /discovery2/port@1 or
> something such, but it is unreleased yet.

Ugh ? What is that supposed to be ?

If it's an ethernet port, it should be called "ethernet".

> The thing is not that there is no info, just to chose which info is best.
> 
> Christoph suggested to not do that though, but use the normal pci stuff and
> match on the host pci id with pci_dev_present. This is what i was thinking of
> doing too, and may be more logical, no ? 

Yah, if there is no meaningful OF name, then probably.

Ben.

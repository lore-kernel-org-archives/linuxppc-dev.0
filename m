Date: Thu, 1 Apr 2004 11:17:15 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040401191715.GC3786@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 02:10:00PM -0500, John Whitney wrote:
> >I think we should use "device" parameter passed to DMA API for such
> >stuff, it
> >already has a member "struct bus_type* bus".
> >
>
> This effectively makes the DMA API a superset of the PCI DMA API (the
> DMA API would recognize a PCI device, and handle it accordingly)?

Yes, I think it's a goal.

> It
> sounds like a good solution to me, although I'd like to see the
> "device" structure get that DMA offset I mentioned, so the DMA API
> wouldn't have to have a special case for each new bus-type added (PLB,
> PCI, OCP, CPM, whatever), as it does now for PCI vs. non-PCI.  (That
> assumes bus offset is the only difference that needs to be handled...)

I think we should add such info to a structure which describes the _bus_, not
_device_.
I'm not "new-device-model" guru, so I cannot comment _how_ this can be
implemented though :)

Eugene.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

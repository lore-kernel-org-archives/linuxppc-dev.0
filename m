Date: Thu, 1 Apr 2004 14:00:18 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Michael R. Zucca" <mrz5149@acm.org>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040401220018.GA4130@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <406C8104.9050609@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 03:52:20PM -0500, Michael R. Zucca wrote:
>
> >I think we should add such info to a structure which describes the _bus_,
> >not
> >_device_.
> >I'm not "new-device-model" guru, so I cannot comment _how_ this can be
> >implemented though :)
>
> A bus description alone is not sufficient. A generic DMA API should take
> both a source and destination device.

well, DMA API we are talking about handles only device <-> system memory, so
only _one_ device (which is currently done) is need.

> Between any two sources and
> destinations there may be several intervening bridges, which potentially
> means programming those bridges and/or doing several address translations.

In case of several bridges, I think it's simpler just to assign _different_
buses for each bus connected by a bridge.

Eugene.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

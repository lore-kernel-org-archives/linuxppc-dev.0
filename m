Date: Fri, 2 Apr 2004 07:45:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040402054539.GA18600@lst.de>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 02:10:00PM -0500, John Whitney wrote:
> sounds like a good solution to me, although I'd like to see the
> "device" structure get that DMA offset I mentioned, so the DMA API
> wouldn't have to have a special case for each new bus-type added (PLB,

That doesn't work because there's much more complex bridges that do
complicated remapping of the bus addresses and it's not a simple offset.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Subject: Re: Generic DMA Core
From: Adrian Cox <adrian@humboldt.co.uk>
To: John Whitney <johnw@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <034E6544-833B-11D8-9FF0-000A95A07384@sands-edge.com>
References: <034E6544-833B-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain
Message-Id: <1080802903.7999.718.camel@newt>
Mime-Version: 1.0
Date: Thu, 01 Apr 2004 08:01:44 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-03-31 at 18:44, John Whitney wrote:
> I have written a generic DMA core driver (drivers/dma/) that accepts
> registrations from low-level DMA hardware drivers (providers).  I've
> also written a provider driver for the MPC10x dual-channel DMA
> controller.
> [...]
> Is there any interest in this code, and if so, what would be the best
> way for going about getting it included in the kernel?

I'd be interested in seeing it. I experimented with something similar
for Linux 2.4.

As for getting into the kernel, the main problem I see is that currently
nothing else uses it. You may need to do a couple of things: write a
dummy provider for machines without DMA engines, and use it to
accelerate an existing process.

The main use of these DMA engines is to transfer data to PCI cards which
lack built-in DMA. So you probably need to find some examples and modify
them to use your API.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sat, 3 Apr 2004 09:33:58 -0800
From: Brad Boyer <flar@allandria.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	"Michael R. Zucca" <mrz5149@acm.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040403173358.GA19686@pants.nu>
References: <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org> <20040401220018.GA4130@gate.ebshome.net> <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com> <406DB5DC.6060508@acm.org> <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com> <406DCAF1.1040602@acm.org> <F6294392-84E8-11D8-9FF0-000A95A07384@sands-edge.com> <1080978857.7999.813.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1080978857.7999.813.camel@newt>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Apr 03, 2004 at 08:54:18AM +0100, Adrian Cox wrote:
> I've not encountered a chip with more than one platform DMA controller.
> Rather than having a top level API with low-level providers, consider
> picking the implementation at Kconfig time.

It's generally better not to decide this sort of thing at compile time
if you want it to be portable. If you want an example of a kernel that
can do everything, try compiling Linux for m68k sometime. You can have
one kernel that can support Amigas, Ataris, Macs, and a few others all
at once. I'm sure it goes without saying that pretty much everything
other than the base CPU is different on each platform.  In fact, even
just with 68k based Macs, Apple changed stuff so often that any two
models may have almost nothing in common.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

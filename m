Subject: Re: Problems with dma_alloc_coherent()
From: Adrian Cox <adrian@humboldt.co.uk>
To: Brad Boyer <flar@allandria.com>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	"Michael R. Zucca" <mrz5149@acm.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040403173358.GA19686@pants.nu>
References: <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org>
	 <20040401220018.GA4130@gate.ebshome.net>
	 <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
	 <406DB5DC.6060508@acm.org>
	 <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com>
	 <406DCAF1.1040602@acm.org>
	 <F6294392-84E8-11D8-9FF0-000A95A07384@sands-edge.com>
	 <1080978857.7999.813.camel@newt>  <20040403173358.GA19686@pants.nu>
Content-Type: text/plain
Message-Id: <1081066513.7999.830.camel@newt>
Mime-Version: 1.0
Date: Sun, 04 Apr 2004 09:15:13 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-04-03 at 18:33, Brad Boyer wrote:

> It's generally better not to decide this sort of thing at compile time
> if you want it to be portable. If you want an example of a kernel that
> can do everything, try compiling Linux for m68k sometime. You can have
> one kernel that can support Amigas, Ataris, Macs, and a few others all
> at once. I'm sure it goes without saying that pretty much everything
> other than the base CPU is different on each platform.  In fact, even
> just with 68k based Macs, Apple changed stuff so often that any two
> models may have almost nothing in common.

In the sort of embedded systems which have these DMA controllers, there
is generally no way for Linux to tell which hardware it is running on.
For example, there is no way to tell that this MPC8260 board was made by
North American Veeblefetzer, or that GPIO 15 is the MII clock and GPIO
21 is the MII data, or that those two lines were reassigned on the next
revision of the board. We're already stuck with compiling for a very
specific model, and we're frequently trying to save space in the boot
flash.

- Adrian Cox


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

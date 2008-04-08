Return-Path: <benh@kernel.crashing.org>
Subject: Re: ppc440 caches - change proposal [RFC]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Bonesio <john.bonesio@xilinx.com>
In-Reply-To: <20080408225329.5EC171A8007D@mail11-dub.bigfish.com>
References: <20080408225329.5EC171A8007D@mail11-dub.bigfish.com>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 08:56:55 +1000
Message-Id: <1207695415.14711.11.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-04-08 at 15:53 -0700, John Bonesio wrote:
> I was thinking it might be good to have the kernel initialize these
> cache control registers in it's own start up code. Or perhaps this
> could be done in the kernel's simple bootloader. We could probably put
> this change in a Xilinx specific startup file, but this change doesn't
> seem specific to Xilinx FPGA boards.

The kernel's wrapper would be a good place to put that I suspect. That's
the kind of thing that should be provided as a "library" function to be
optionally called by platform code. Either in the wrapper or the main
kernel platform code.

Cheers,
Ben.

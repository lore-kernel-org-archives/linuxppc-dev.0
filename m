Date: Fri, 23 Jul 2004 07:02:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] export m8xx_cpm_hostalloc
Message-ID: <20040723140231.GA21814@smtp.west.cox.net>
References: <1090590567.3939.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090590567.3939.20.camel@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 23, 2004 at 03:49:27PM +0200, Andreas Oberritter wrote:

> Hi Tom,
>
> to build an i2c driver as a module, m8xx_cpm_hostalloc must be exported.
> We are using a driver which is not in the kernel tree[1]. I tried to
> merge the in-kernel i2c driver with it, but I failed and don't have the
> time to investigate why our driver works with the dbox2 board and the
> in-kernel driver doesn't.
>
> This function has been exported in 2.4. Is it ok to do that for 2.6,
> too?

Must the driver use hostalloc?  I didn't think that i2c was called so
early that kmalloc/bootmem_alloc() (or so) couldn't be used.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

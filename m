Date: Fri, 23 Jul 2004 08:38:56 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Andreas Oberritter <obi@saftware.de>
Subject: Re: [PATCH] export m8xx_cpm_hostalloc
Message-ID: <20040723083856.A25212@home.com>
References: <1090590567.3939.20.camel@localhost.localdomain> <20040723140231.GA21814@smtp.west.cox.net> <6658EF7A-DCB6-11D8-BC2F-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6658EF7A-DCB6-11D8-BC2F-003065F9B7DC@embeddededge.com>; from dan@embeddededge.com on Fri, Jul 23, 2004 at 10:41:36AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 23, 2004 at 10:41:36AM -0400, Dan Malek wrote:
>
> On Jul 23, 2004, at 10:02 AM, Tom Rini wrote:
>
> > Must the driver use hostalloc?  I didn't think that i2c was called so
> > early that kmalloc/bootmem_alloc() (or so) couldn't be used.
>
>
> Should use ...consistent_alloc()

That doesn't exist in 2.6. Use dma_alloc_coherent().

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

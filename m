Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 05/12] of: add common header for flattened device
	tree representation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20091007043052.16890.15975.stgit@angua>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Oct 2009 16:14:27 +1100
Message-Id: <1254892467.6035.273.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-06 at 22:30 -0600, Grant Likely wrote:

> --- /dev/null
> +++ b/include/linux/of_fdt.h
> @@ -0,0 +1,30 @@
> +/*
> + * Definitions for working with the Flattened Device Tree data format
> + *
> + * Copyright (C) 1996-2005 Paul Mackerras.
> + *
> + * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
> + * Updates for SPARC by David S. Miller
> + * Merged to common code by Grant Likely

I think you should prune the above. Make it (c) myself since I wrote the
FDT code initially. You can add back (c) of other people as you add more
stuff here I suppose.

No big deal tho.

Ben.

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _LINUX_OF_FDT_H
> +#define _LINUX_OF_FDT_H
> +
> +/* Definitions used by the flattened device tree */
> +#define OF_DT_HEADER		0xd00dfeed	/* marker */
> +#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
> +#define OF_DT_END_NODE		0x2		/* End node */
> +#define OF_DT_PROP		0x3		/* Property: name off, size,
> +						 * content */
> +#define OF_DT_NOP		0x4		/* nop */
> +#define OF_DT_END		0x9
> +
> +#define OF_DT_VERSION		0x10
> +
> +#endif /* _LINUX_OF_FDT_H */

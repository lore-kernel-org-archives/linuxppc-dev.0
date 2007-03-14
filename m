Return-Path: <jdl@jdl.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Update documentation for flat device tree format v17 
In-Reply-To: Your message of "Wed, 14 Mar 2007 11:50:40 +1100."
	<20070314005040.GF25514@localhost.localdomain>
References: <20070314005040.GF25514@localhost.localdomain> 
Date: Wed, 14 Mar 2007 15:44:30 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HRaKk-0000Pi-3x@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> This patch updates booting-without-of.txt to describe version 17 of
> the flattened device tree format.  Version 17 is a small, backwards
> compatible change from version 16, adding an extra field giving the
> size of the device tree's structure block.  At this time, the kernel
> has no use for the extra information, however its presence can make
> life easier for bootloaders or other software manipulating the tree.
> 
> In addition this patch adds information on the size_dt_strings field
> of the device tree header, present since version 3 of the flattened
> tree format, but omitted from the documentation.  It also makes
> changes to consistently refer to versions 16 and 17 as versions 16 and
> 17 in decimal, rather than version 0x10 which was occasionally used
> for version 16 previously.
> 
> Finally, we also add the new field to the definition of the device
> tree header structure in prom.h
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> 
> Paulus, please apply.

Paul,

I have applied the Version 17 Updates patch to my DTC tree.

Acked-by: Jon Loeliger <jdl@freescale.com>

Thanks,
jdl

Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Handle v16 and re-ordered trees for r/w 
In-Reply-To: Your message of "Thu, 01 Nov 2007 11:37:31 +1100."
	<20071101003731.GG16119@localhost.localdomain>
References: <20071101003731.GG16119@localhost.localdomain> 
Date: Thu, 01 Nov 2007 08:08:01 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1InZmD-0003jL-Td@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> Currently all the read/write functions in libfdt require that the
> given tree be v17, and further, that the tree has the memory
> reservation block, structure block and strings block stored in that
> physical order.
> 
> This patch eases these constraints, by making fdt_open_int() reorder
> the blocks, and/or convert the tree to v17, so that it will then be
> ready for the other read-write functions.
> 
> It also extends fdt_pack() to actually remove any gaps between blocks
> that might be present.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl

Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Add functions to get/add/delete memory reservemap entries
In-Reply-To: Your message of "Wed, 10 Oct 2007 17:12:12 +1000."
	<20071010071212.GC6135@localhost.localdomain>
References: <20071010071212.GC6135@localhost.localdomain> 
Date: Mon, 15 Oct 2007 08:37:06 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IhQ82-0002uY-Ad@jdl.com>
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
> This patch adds functions to libfdt for accessing the memory
> reservation map section of a device tree blob.  fdt_num_mem_rsv()
> retreives the number of reservation entries in a dtb, and
> fdt_get_mem_rsv() retreives a specific reservation entry.
> fdt_add_mem_rsv() adds a new entry, and fdt_del_mem_rsv() removes a
> specific numbered entry.
> 
> Testcases for these new functions are also included.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl

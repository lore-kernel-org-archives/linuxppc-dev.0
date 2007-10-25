Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Remove un-const-safe fdt_set_header macro 
In-Reply-To: Your message of "Thu, 25 Oct 2007 14:29:38 +1000."
	<20071025042938.GD24856@localhost.localdomain>
References: <20071025042938.GD24856@localhost.localdomain> 
Date: Thu, 25 Oct 2007 09:49:38 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Il41i-00089f-6B@jdl.com>
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
> The fdt_set_header() macro casts an arbitrary pointer into (struct
> fdt_header *) to set fdt header fields.  While we need to change the
> type, so that we can use this macro on the usual (void *) used to
> represent a device tree blob, the current macro also casts away any
> const on the input pointer, which loses an important check.
> 
> This patch replaces the fdt_set_header() macro with a set of inline
> functions, one for each header field which do a similar thing, but
> which won't silently remove const from a given pointer.  This approach
> is also more in keeping with the individual accessor macros we use for
> reading fdt header fields.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl

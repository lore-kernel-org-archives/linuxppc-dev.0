Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Rename and publish _fdt_next_tag() 
In-Reply-To: Your message of "Wed, 24 Oct 2007 11:06:09 +1000."
	<20071024010609.GH10595@localhost.localdomain>
References: <20071024002852.GG10595@localhost.localdomain>
	<20071024010609.GH10595@localhost.localdomain>
Date: Wed, 24 Oct 2007 09:59:07 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IkhhL-00011N-8n@jdl.com>
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
> Although it's a low-level function that shouldn't normally be needed,
> there are circumstances where it's useful for users of libfdt to use
> the _fdt_next_tag() function.  Therefore, this patch renames it to
> fdt_next_tag() and publishes it in libfdt.h.
> 
> In addition, this patch adds a new testcase using fdt_next_tag(),
> dtbs_equal_ordered.  This testcase tests for structural equality of
> two dtbs, including the order of properties and subnodes, but ignoring
> NOP tags, the order of the dtb sections and the layout of strings in
> the strings block.  This will be useful for testing other dtc
> functionality in the future.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl

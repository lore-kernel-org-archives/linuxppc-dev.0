Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Make unit address optional for finding nodes 
In-Reply-To: Your message of "Fri, 28 Sep 2007 15:51:04 +1000."
	<20070928055104.GE25743@localhost.localdomain>
References: <20070928055104.GE25743@localhost.localdomain> 
Date: Mon, 15 Oct 2007 08:35:18 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IhQ6I-0002rq-E0@jdl.com>
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
> At present, the fdt_subnode_offset() and fdt_path_offset() functions
> in libfdt require the exact name of the nodes in question be passed,
> including unit address.
> 
> This is contrary to traditional OF-like finddevice() behaviour, which
> allows the unit address to be omitted (which is useful when the device
> name is unambiguous without the address).
> 
> This patch introduces similar behaviour to
> fdt_subnode_offset_namelen(), and hence to fdt_subnode_offset() and
> fdt_path_offset() which are implemented in terms of the former.  The
> unit address can be omitted from the given node name.  If this is
> ambiguous, the first such node in the flattened tree will be selected
> (this behaviour is consistent with IEEE1275 which specifies only that
> an arbitrary node matching the given information be selected).
> 
> This very small change is then followed by many more diffs which
> change the test examples and testcases to exercise this behaviour.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Applied.


> Jon, I initially considered making this behaviour optional,
> i.e. adding a flag to subnode_offset() determining if it needed exact
> matches or name-without-address matches.  I couldn't see that it was
> actually any use, though.

Yeah, sounds fine to me too.

Thanks,
jdl

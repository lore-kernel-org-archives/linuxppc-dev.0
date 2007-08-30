Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Fix handling of trailing / in fdt_path_offset() 
In-Reply-To: Your message of "Wed, 29 Aug 2007 12:22:50 +1000."
	<20070829022250.GA25468@localhost.localdomain>
References: <20070829022250.GA25468@localhost.localdomain> 
Date: Thu, 30 Aug 2007 08:52:01 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IQkRF-0004aU-Jh@jdl.com>
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
> Currently, fdt_path_offset() returns FDL_ERR_BADOFFSET if given a path
> with a trailing '/'.  In particular this means that
> fdt_path_offset("/") returns FDT_ERR_BADOFFSET rather than 0 as one
> would expect.
> 
> This patch fixes the function to accept and ignore trailing '/'
> characters.  As well as allowing fdt_path_offset("/") this means that
> fdt_path_offset("/foo/") will return the same as
> fdt_path_offset("/foo") which seems in keeping with the principle of
> least surprise.
> 
> This also adds a testcase to ensure that fdt_path_offset("/") returns
> 0 as it should.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl

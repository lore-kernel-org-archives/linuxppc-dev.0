Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Whitespace cleanup 
In-Reply-To: Your message of "Tue, 18 Sep 2007 11:44:04 +1000."
	<20070918014404.GB30766@localhost.localdomain>
References: <20070918014404.GB30766@localhost.localdomain> 
Date: Tue, 18 Sep 2007 10:03:01 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IXebN-0000lT-Qq@jdl.com>
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
> This large patch removes all trailing whitespace from dtc (including
> libfdt, the testsuite and documentation).  It also removes a handful
> of redundant blank lines (at the end of functions, or when there are
> two blank lines together for no particular reason).
> 
> As well as anything else, this means that quilt won't whinge when I go
> to convert the whole of libfdt into a patch to apply to the kernel.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl

Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Test rw functions on more trees 
In-Reply-To: Your message of "Fri, 28 Sep 2007 14:57:01 +1000."
	<20070928045701.GB25743@localhost.localdomain>
References: <20070928045701.GB25743@localhost.localdomain> 
Date: Mon, 15 Oct 2007 08:34:30 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IhQ5W-0002qx-1O@jdl.com>
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
> At present, the testcases for read/write functions (setprop,
> del_property and del_node) are only invoked on the single
> asm-generated tree, not on any of the other tree images which should
> be equivalent.  The functions in question will (correctly) not work on
> the "unfinished" tree output from sw_tree1, but should work on most of
> the others.
> 
> This patch extends the run_tests script to invoke the r/w testcases on
> more example trees.  The testsuite still passes clean with this
> addition.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl

Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove some redundant testcases 
In-Reply-To: Your message of "Wed, 21 Nov 2007 11:29:18 +1100."
	<20071121002918.GC13156@localhost.localdomain>
References: <20071121002918.GC13156@localhost.localdomain> 
Date: Mon, 26 Nov 2007 15:21:10 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IwlOA-0001cY-91@jdl.com>
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
> This patch removes a number of testcases from the testsuite that are
> extremely unlikely to find any bugs that won't be found by the other
> tests.  This speeds up the testsuite.
> 
> 	- Both loops across the various tree block layouts run the
> tree1_tests on the basic mangled tree.  This is completely redundant,
> so remove the second copy. This removes 456 testcases.
> 
> 	- We currently run tree1_tests on various trees manipulated by
> move_and_save.  We replace those with just a dtbs_equal_ordered test
> to check that the manipulated tree is equal to the original.  What
> we're testing here is that fdt_move() operates correctly - it's very
> unlikely it would succeed well enough for the ordered_equal test to
> succeed, but the tree1_tests would fail on the result.  This removes
> 162 testcases.
> 
> 	- Currently we re-ordered with mangle-layout both the basic
> test_tree1.dtb and sw_tree1.test.dtb.  Since we've already checked
> that these dtbs are equivalent with dtbs_ordered_equal, it's very
> unlikely that the tests would fail on one but not the other.
> Therefore reduce this to only using test_tree1.dtb.  This removes 828
> testcases.


Applied.

Thanks,
jdl

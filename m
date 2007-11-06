Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Fix sw_tree1 testcase 
In-Reply-To: Your message of "Tue, 06 Nov 2007 10:42:45 +1100."
	<20071105234245.GA27067@localhost.localdomain>
References: <20071105053844.GC21064@localhost.localdomain>
	<E1Ip3bp-000260-Of@jdl.com>
	<20071105234245.GA27067@localhost.localdomain>
Date: Tue, 06 Nov 2007 12:21:51 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IpT3f-0004LX-Ru@jdl.com>
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
> Crud, I screwed up and gave you an intermediate version of the patch
> which tried to do the same thing for rw_tree1.  For that to work, I'll
> need to write a dtbs_equal_notordered test.
> 
> Corrected version below.
> 
> libfdt: Fix sw_tree1 testcase
> 
> There is a bug in the sw_tree1 testcase / utility which puts two
> "compatible" properties in one node in the output tree.  This patch
> fixes the bug, and also adds a new test checking that the sw_tree1
> output is equal to test_tree1.dtb as its supposed to be, which should
> catch future errors of this type.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl

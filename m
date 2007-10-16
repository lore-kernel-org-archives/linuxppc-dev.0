Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Don't delete *.test.dtb between testgroups 
In-Reply-To: Your message of "Tue, 16 Oct 2007 13:53:20 +1000."
	<20071016035320.GQ26787@localhost.localdomain>
References: <20071016035320.GQ26787@localhost.localdomain> 
Date: Tue, 16 Oct 2007 07:39:25 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ihlhm-0002Vo-0T@jdl.com>
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
> The dtc/libfdt testsuite creates a number of .dtb files during its
> run.  To ensure a clean test run, these are currently deleted before
> each group of tests.
> 
> This is, in fact, a mistake, since if something goes wrong in the
> first group of tests, deleting the .dtb at the beginning of the second
> group of tests makes it harder to figure out what the problem was.
> 
> This patch changes the script to only delete the files once, before
> the whole test run.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl

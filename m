Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Test on trees with different block layouts 
In-Reply-To: Your message of "Thu, 25 Oct 2007 15:05:58 +1000."
	<20071025050558.GE24856@localhost.localdomain>
References: <20071025050558.GE24856@localhost.localdomain> 
Date: Thu, 25 Oct 2007 09:56:52 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Il48i-0000Tg-Rk@jdl.com>
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
> At present, all the example dtbs we use in the testsuite are version
> 17 and have reservation map, then structure block then strings block
> (the natural ordering based on alignment constraints).  However, all
> libfdt's read-only and in-place write functions should also work on
> v16 trees, and on trees with other layouts.
> 
> This patch adds a testcase / utility function to rearrange the blocks
> of a dtb and/or regress a v17 tree to v16, and uses it to run tests on
> trees with different layouts and versions.
> 
> Signed-off-by: David Gibson <david@tgibson.dropbear.id.au>

Applied.

jdl

Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Cleanup testsuite organization 
In-Reply-To: Your message of "Mon, 17 Sep 2007 14:39:24 +1000."
	<20070917043924.GJ32725@localhost.localdomain>
References: <20070917043924.GJ32725@localhost.localdomain> 
Date: Mon, 17 Sep 2007 14:23:50 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IXMCE-0002mK-Tt@jdl.com>
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
> run_tests.sh from the dtc testsuite currently has a facility ro run
> just "functional" or just "stress" tests.  This distinction is carried
> over from libhugetlbfs where the test framework originated, and where
> it made sense.
> 
> In dtc, we have no stress tests, so running these subsections isn't
> particularly interesting.  This patch removes these test subsets,
> instead defining a single "libfdt" test subset for testcases related
> to libfdt (and not dtc proper only.  Currently that's all of the
> testcases, but with any luck we'll have some dtc testcases in the
> future.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl

Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Don't use env(1) in testsuite 
In-Reply-To: Your message of "Tue, 20 Nov 2007 22:14:12 +1100."
	<20071120111412.GA13156@localhost.localdomain>
References: <20071120111412.GA13156@localhost.localdomain> 
Date: Tue, 20 Nov 2007 09:09:40 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IuUjM-00022l-AC@jdl.com>
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
> The run_tests.sh script currently invokes the testcase binaries via
> env(1).  This behaviour is inherited from the libhugetlbfs testsuite
> which uses this approach to easily set various configuration
> environment variables in testcases.
> 
> We don't use that for dtc, and are unlikely to ever want to.
> Therefore this patch removes that technique, which substantially
> speeds up the testsuite.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl

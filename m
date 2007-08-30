Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Fix summary calculation in testsuite 
In-Reply-To: Your message of "Wed, 29 Aug 2007 12:18:51 +1000."
	<20070829021851.GA25233@localhost.localdomain>
References: <20070829021851.GA25233@localhost.localdomain> 
Date: Thu, 30 Aug 2007 08:51:35 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IQkQp-0004aD-Hj@jdl.com>
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
> The bookkeeping for producing the testsuite summary (total number of
> tests passed, failed and so forth) is broken.  It uses $? across
> several tests, but for checks after the first, the value of $? will no
> longer contain the original return code, but just that from the
> previous test.  This patch fixes the problem.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl

Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Optimise by default, fix warnings thus uncovered 
In-Reply-To: Your message of "Fri, 31 Aug 2007 16:21:23 +1000."
	<20070831062123.GC29721@localhost.localdomain>
References: <20070831062123.GC29721@localhost.localdomain> 
Date: Fri, 31 Aug 2007 08:38:56 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IR6i8-0002gz-2X@jdl.com>
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
> This patch turns on optimisation in the Makefile by default.  With the
> optimizer on, some uninitialized variable warnings (one real, two
> bogus) are now generated.  This patch also squashes those again.

Applied.

Thanks,
jdl

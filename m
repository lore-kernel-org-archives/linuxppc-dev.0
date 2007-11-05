Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Don't include libfdt in global LDFLAGS 
In-Reply-To: Your message of "Fri, 02 Nov 2007 15:15:17 +1100."
	<20071102041517.GJ19839@localhost.localdomain>
References: <20071102041517.GJ19839@localhost.localdomain> 
Date: Mon, 05 Nov 2007 08:54:20 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ip3LI-00072J-Si@jdl.com>
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
> Remove the uneccessary LDFLAGS from the top-level makefile.  It only
> added libfdt/ to the link path.  dtc doesn't need libfdt at all, and
> the testcases which do, already link libfdt.a by explicit path.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl

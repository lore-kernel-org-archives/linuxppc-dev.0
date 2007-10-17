Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Restore missing code for testcases 
In-Reply-To: Your message of "Wed, 17 Oct 2007 11:23:57 +1000."
	<20071017012357.GE28260@localhost.localdomain>
References: <20071017012357.GE28260@localhost.localdomain> 
Date: Wed, 17 Oct 2007 07:11:29 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ii7kH-0002Jg-RQ@jdl.com>
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
> Recent commits 333542fabf8720b881e992a5abca32ef4bcb841a and
> fd1bf3a5ae46962528ef89a824261a88830758a2 added new testcases to dtc.
> However, although the testcases were added to the Makefile and
> run_tests.sh, one of the .c files for the testcase was omitted from
> the patch in each case.
> 
> This patch restores the missing testcase code.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.


> jdl, you should
> really run a "make check" before committing my patches...

In the past, I have.  I confess, this last round I only
compiled tested things.  I'm really still catching up some...

jdl

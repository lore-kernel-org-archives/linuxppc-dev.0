Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Add testcases for tree checks 
In-Reply-To: Your message of "Tue, 20 Nov 2007 16:24:23 +1100."
	<20071120052423.GC4356@localhost.localdomain>
References: <20071120052423.GC4356@localhost.localdomain> 
Date: Tue, 20 Nov 2007 09:09:17 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IuUiz-00022Y-E1@jdl.com>
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
> This patch adds a group of testcases to check that dtc correctly
> rejects trees with various structural errors.
> 
> To make things easier to test, we change dtc so that failing checks
> (as opposed to other errors) result in exit code 2.
> 
> This patch also fixes an embarrasing bug uncovered by these new tests:
> check_phandles() worked out if the tree's phandles were valid, then
> throws that information away and returns success always.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> NOTE! jdl, you'll need to chmod +x tests/dtc-checkfails.sh before you
> git commit this - it's a new shell script and patch can't encode the
> permissions info.
> 
> Index: dtc/tests/dup-nodename.dts
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ dtc/tests/dup-nodename.dts	2007-11-20 16:02:22.000000000 +1100


Actually, this is the official third time now that it would have
been significantly nicer had you been using git for patches as
it does correctly handle excute permissions properly in patches.

And, it allows for side-band commentary such as your NOTE!, above,
to be included in the patch mail, but not in the patch log itself
such that it too doesn't have to be "git commit --amend"'ed out
as well.

In any event, Applied and Adjusted.

jdl

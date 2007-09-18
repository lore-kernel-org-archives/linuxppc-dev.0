Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Add basic testcases for dtc 
In-Reply-To: Your message of "Tue, 18 Sep 2007 10:33:40 +1000."
	<20070918003340.GA30766@localhost.localdomain>
References: <20070918003340.GA30766@localhost.localdomain> 
Date: Tue, 18 Sep 2007 10:02:37 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IXeaz-0000lF-HQ@jdl.com>
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
> This patch adds a handful of simple testcases for dtc.  It adds a dts
> file which should generate the same sample tree as is used for the
> libfdt testcases, and tests invoking dtc on this dts, plus the
> standard batch of libfdt cases on the resulting dtb, which effectively
> checks that the dtb is correct.
> 
> Because the test framework assumes each testcase is an executable with
> the right output conventions, we use a little shell script, dtc.sh, as
> a wrapper around dtc itself.  It simply invokes dtc and returns a PASS
> or FAIL depending on whether dtc returned an error.
> 
> It's not much, but it's a start.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Applied.

> NB: Jon, you won't be able to simply git-applymbox this and have it
> work.  You'll need to manually add execute permission to tests/dtc.sh
> before git commiting it, since I can't encode the permissions in a
> patch.  Sorry for the inconvenience, but it didn't really seem worth
> setting up my own git to pull from just for that.

No problem.  Too bad you can't just use git, though... :-)

jdl

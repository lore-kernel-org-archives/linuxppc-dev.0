Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Nov 2007 09:03:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: dtc: Add testcases for tree checks
Message-ID: <20071120220309.GB13156@localhost.localdomain>
References: <20071120052423.GC4356@localhost.localdomain>
	<E1IuUiz-00022Y-E1@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IuUiz-00022Y-E1@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 20, 2007 at 09:09:17AM -0600, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > This patch adds a group of testcases to check that dtc correctly
> > rejects trees with various structural errors.
> > 
> > To make things easier to test, we change dtc so that failing checks
> > (as opposed to other errors) result in exit code 2.
> > 
> > This patch also fixes an embarrasing bug uncovered by these new tests:
> > check_phandles() worked out if the tree's phandles were valid, then
> > throws that information away and returns success always.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > 
> > NOTE! jdl, you'll need to chmod +x tests/dtc-checkfails.sh before you
> > git commit this - it's a new shell script and patch can't encode the
> > permissions info.
> > 
> > Index: dtc/tests/dup-nodename.dts
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ dtc/tests/dup-nodename.dts	2007-11-20 16:02:22.000000000 +1100
> 
> 
> Actually, this is the official third time now that it would have
> been significantly nicer had you been using git for patches as
> it does correctly handle excute permissions properly in patches.

Well, yes.  But, IMO, every time anyone other that you or I has
commented on one of these patches as it goes past counts as an
occasion when it's better that I've been using patches, rather than
pushing to you direct with git.

> And, it allows for side-band commentary such as your NOTE!, above,
> to be included in the patch mail, but not in the patch log itself
> such that it too doesn't have to be "git commit --amend"'ed out
> as well.

Actually, that should be possible with mails too, it's just that I
forgot the --- line.

> In any event, Applied and Adjusted.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

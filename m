Date: Wed, 30 Oct 2002 07:10:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Chris Zimman <chris@cryptoapps.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel tree and 2.4.19
Message-ID: <20021030141026.GL688@opus.bloom.county>
References: <20021029114712.J25527@evilcat.ioinc.tucson.az.us> <20021029192059.GI688@opus.bloom.county> <20021030095346.GA16076@mail.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021030095346.GA16076@mail.cryptoapps.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 30, 2002 at 01:53:46AM -0800, Chris Zimman wrote:

> I'm just learning BitKeeper now -- and have a similar question.  I want
> to get the 2.4.19 (or 2.4.18, etc.) version of the kernel, but with all
> the enhancements for the Walnut platform (eg. OCP ethernet, PCI support,
> etc.)
>
> What I've been doing is cloning with -rv2.4.19, but as you pointed out,
> I think that gets me the kernel.org 2.4.19.  I'm clearly confused on how
> the merging works with respect to the mainline tree.

Basically a tag, like v2.4.19 works in BK in a similar way to CVS.  It
is the state of _a_ tree when that patch was applied.  But unlike CVS,
that tree can be pulled into another tree (somewhat like merging
branches, but only for thinking the problem out).  After this merge
happens however, no symbolic tag is made in the next tree.

So, to track down when a tag made in the linux_2_4 tree was merged into
the linuxppc_2_4 tree, you have to do a 'bk changes' and look by hand,
or a bk sccstool (graphical) and look at each ChangeSet.  This is
similar to the process for linuxppc_2_4_devel, except you want to see
when then linuxppc_2_4 tree, which had just had the linux_2_4 tree of
the version you want, was merged into linuxppc_2_4_devel.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17348.60119.801379.127209@cargo.ozlabs.ibm.com>
References: <17348.60119.801379.127209@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1136993167.29751.123.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 11 Jan 2006 09:26:07 -0600
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: powerpc.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-01-11 at 05:24, Paul Mackerras wrote:
> All of the patches in the powerpc.git tree have now been either sent
> upstream to Linus' tree, or reverted.

Yeah!

> In future I'd like to be able to ask Linus to pull the powerpc.git
> tree, without cluttering up his tree with those superseded commits.

Can you give us a work-flow statement that covers
the powerpc.git and powerpc-merge.git trees?  When do
patches hit on-or-the-other tree?  What is the purpose
of the two trees, especially given that "merge" work
is also "development" work.  When will the two trees
be slated for upstream Linus pullage?

That sort of thing. :-)

> That means I need to reset the powerpc.git tree to be the same as
> Linus' tree now.

Oh boy!  One shoe...

> That means that anyone who is following the powerpc.git tree by doing
> pulls periodically will need to reset their tree too.  Otherwise each
> pull will do an unnecessary merge.

Two shoe...

> If that would cause people serious heartburn, I can instead abandon
> the powerpc.git tree and start a new development tree
> (powerpc-devel.git perhaps).

'S ok with me either way.  Just give us a "I did this, you
now need to do that" statement as needed!

Now, what we really need is a U-Boot tree in which we can
dump the corresponding OF bits.  Any chance we could get
one set up at kernel.org that might later be pulled into
WD's tree and simplify his life too?

Thanks!
jdl

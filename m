Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17348.60119.801379.127209@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jan 2006 22:24:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: powerpc.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All of the patches in the powerpc.git tree have now been either sent
upstream to Linus' tree, or reverted.

For various reasons I didn't just ask Linus to pull the powerpc.git
tree, but instead cherry-picked the commits into the powerpc-merge.git
tree and asked Linus to pull that.  That means that there are now
commits in the powerpc.git tree that are superseded by commits in
Linus' tree.

In future I'd like to be able to ask Linus to pull the powerpc.git
tree, without cluttering up his tree with those superseded commits.
That means I need to reset the powerpc.git tree to be the same as
Linus' tree now.

That means that anyone who is following the powerpc.git tree by doing
pulls periodically will need to reset their tree too.  Otherwise each
pull will do an unnecessary merge.

If that would cause people serious heartburn, I can instead abandon
the powerpc.git tree and start a new development tree
(powerpc-devel.git perhaps).

Comments?

Paul.

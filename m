Date: Thu, 21 Feb 2002 15:10:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: yellowdog-devel@lists.yellowdoglinux.org,
	linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Important things about 'linuxppc_2_4' tree.
Message-ID: <20020221221032.GH719@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As some of you might have noticed, the linuxppc_2_4 tree has been a bit
weird of late.  The short version of it is that the "current"
linuxppc_2_4, as of (Thu, 21 Feb 2002 13:48:57 -0700) will export very
broken trees.  The only good way to fix this is to just forget it
happened, and go back to an older clone.

First, the linuxppc_2_4_devel tree is _NOT_ effected.  If you're only
using this, you're fine.

Second, if you have a copy of this tree and haven't done any local
modifications you can either find the changeset (It's:
"ChangeSet@1.543.1.41, 2002-02-17 09:38:20-07:00, trini@opus.bloom.county"
locally, probably different elsewhere) and do a bk clone -r REV .
../linuxppc_2_4-good, and then rm your old tree.  Or you can just rm and
reclone.

If you've done modifications locally, you will need to do something like
the above clone -r'ing, and if you've checked in changes since then, bk
export -tpatch from your old repo, and bk import -tpatch ../patch . to
your new repo.

Sorry for the inconvenience.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

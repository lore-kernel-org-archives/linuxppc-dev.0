Date: Mon, 25 Jun 2001 16:27:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: ppc @ ppc.bitkeeper.com
Message-ID: <20010625162718.M9808@work.bitmover.com>
References: <20010625134916.Q26686@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010625134916.Q26686@opus.bloom.county>; from trini@kernel.crashing.org on Mon, Jun 25, 2001 at 01:49:16PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi folks, we have the anonymous stuff going here like so

bk://ppc.bitkeeper.com:5000 => linuxppc_2_4
bk://ppc.bitkeeper.com:5001 => linuxppc_2_2
bk://ppc.bitkeeper.com:5002 => linux_2_4
bk://ppc.bitkeeper.com:5003 => linux_2_2
bk://ppc.bitkeeper.com:5005 => linuxppc_2_4_devel

We're working getting BK/web up and we are also making changes so that you'll
be able to do this:

	bk clone http://ppc.bitkeeper.com/linuxppc_2_4

which will work through firewalls.  We have that working now but it requires
some small client side changes so we need to do a crankturn to get you the
new binaries.

While the machine we have has a gig of ram and a fast cpu, and a 1.5Mbit
net connection, we're really prefer that you cloned once and pulled many
times rather than recloning all the time.  Pulling uses tiny amounts of
bandwidth, we can barely detect it, but cloning burns about 35MBytes of
bandwidth.  It's worth getting a copy of BK even if you don't use BK
because it can transfer the data faster than ftp/rsync/whatever because
it already knows what has been changed.  A trivial mirroring command:

	# one time only
	bk clone bk://ppc.bitkeeper.com:5000 linuxppc_2_4

	# Nightly
	cd linuxppc_2_4
	bk pull
	rm -rf ../linuxppc_2_4.export
	bk export . ../linuxppc_2_4.export
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

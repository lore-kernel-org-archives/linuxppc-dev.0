Date: Mon, 25 Aug 2003 09:41:13 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Obsolete and unmaintained 4xx boards in 2.5
Message-ID: <20030825094113.A28149@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

At OLS, Paul and I had a discussion about the overwhelming
number of 4xx boards in the tree.  Recently, I decided to
do a bit of research on which ones are obsolete and/or
unmaintained.  The goal is to remove some of these board ports
since they are in a constant state of brokenness due to the
lack of a maintainer.

If anyone has objections about any of the following boards being
removed, then please volunteer to maintain them.  Several were
maintained long ago by mvista folks but that is no longer the
case.

cedar (np405l)- obsolete (replaced by ash) and unmaintained
redwood4 (stb3) - obsolete (replaced by redwood 5-6) and unmaintained
np4gs3 (np4gs) - unmaintained
oak (403gcx) - unmaintained.  Last devel discussion on this one
	       was Sept. 2001, last query in Nov. 2001.  It would
	       be nice if someone (with hardware) would volunteer
	       to maintain this since the old Tivo is based on 403.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

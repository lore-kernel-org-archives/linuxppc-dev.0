Date: Mon, 25 Jun 2001 13:49:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@ppcbk.mvista.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Anonymous BK mirrors up!
Message-ID: <20010625134916.Q26686@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay.  Official anonymous access to the repos is forthcoming, as I understand.
There's also mirrors of the repos on source.mvista.com.  They get updated
as soon as the commit msg goes through, so they should be fairly up to date
(within a few minutes).  I'll try and throw up a web page or something,
or talk someone with HTML-skills into doing it shortly.  But in the mean time,
here's a quick&dirty Howto:

In this example, we're going to use the linuxppc_2_4 tree.  But all of the
trees are mirrored (2_4, 2_4_devel, 2_5 (historical purpose only!), 2_2 and
the linus trees).

$ cd /usr/local/src/linuxppc_2_4
$ bk parent bk://source.mvista.com/linuxppc_2_4

Painless, eh?

rsync will (hopefully) be up soon as well.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

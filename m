Date: Tue, 5 Feb 2002 09:40:29 -0800 (PST)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: cannot get tree with rsync
Message-ID: <Pine.LNX.4.30.0202050934260.5889-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone else having problems getting the linuxppc_2_4_devel tree from
source.mvista.com. When I get the tree into an empty directory, everything
goes fine. About a week or so ago, though, I began to get errors when
updating the tree. Nothing changed on my end, that I know of other than
after a few days of having the problem, I updated from rsync 2.4.6 to
2.5.2. I have the same problem in both versions.

The error is:
rsync: read error: Connection reset by peer
rsync error: error in rsync protocol data stream (code 12) at io.c(152)
rsync: connection unexpectedly closed (213927 bytes read so far)
rsync error: error in rsync protocol data stream (code 12) at io.c(140)

Any ideas?

Thanks.
--
John Tyner
jtyner@cs.ucr.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

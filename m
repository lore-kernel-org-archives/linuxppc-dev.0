Date: Mon, 28 Dec 1998 20:02:52 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: linux-pmac@samba.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: vger->linus diff
Message-ID: <Pine.LNX.4.05.9812282000410.988-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
  I've put up a small diff of what I've noticed missing from vger in
2.2.0-pre1.  This diff also includes a more stable, and spinlock'ed MACE
driver (module as well), and a newer controlfb (note, once Dan gets back
to school there will be an updated one with this + more goodies). (bmac
update missed our last sync(s) with linus)  The diff is at:
http://dobbstown.yeti.edu/vger-linus.diff

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

From: bob@kunk.jriver.com
Message-ID: <20001120194101.4419.qmail@kunk.jriver.com>
Subject: 2.4.0-test10 benh/SMP/spin_trylock
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 20 Nov 2000 13:41:00 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If CONFIG_SMP is not set for the benh devel tree, the ppp_async.c
file will have an undefined spin_trylock.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

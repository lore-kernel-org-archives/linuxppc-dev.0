Message-ID: <20001212061238.1756.qmail@kunk.jriver.com>
Subject: Mace woes SOLVED!
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 12 Dec 2000 00:12:38 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think I've finally figured out where the mace ethernet driver
foobars. It appears to have a problem when  CONFIG_SYN_COOKIES is on.

Did some flood pings and large ftp transfers and so far it's working
fine with it off.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 25 Sep 2001 17:17:43 -0700
From: Larry McVoy <lm@bitmover.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: T1 line is here
Message-ID: <20010925171743.H28189@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Our new T1 line is installed and working.  We'll be updating the repo
server so that it resolves to the T1 line in the next day or two; we'll
leave the old address connected as well so things will continue to work
while the DNS entries time out.

It should be pretty zippy, the router in our office with the repository
server is 192.132.92.1 and pings from Cort's machine are 41 milliseconds,
pings to the east cost are 60 milliseconds.  Those are both 30 ms less
than our DSL line, so not only is the bandwidth better, the latency seems
better as well.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

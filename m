Date: Fri, 21 May 2004 00:40:18 -0700
From: Jamie Heilman <jamie@audible.transient.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: BriQ & Linux 2.6
Message-ID: <20040521074018.GD8520@audible.transient.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I attempted to boot a 2.6.6 kernel on my BriQ today and ran into a
snag... it appears that the IBM,CPC710 PCI bridge handling stuff
didn't make it into 2.6.  As such the host won't boot as all the
goodies hanging off the PCI bus vanish.  Any plans to roll the code
forward in the near future?

--
Jamie Heilman                     http://audible.transient.net/~jamie/
"Most people wouldn't know music if it came up and bit them on the ass."
                                                        -Frank Zappa

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

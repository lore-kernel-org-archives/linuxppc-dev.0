Date: Tue, 2 Apr 2002 23:04:11 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: GT64260 merge warning
Message-ID: <20020402230411.G6003@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm getting close to a point where I want to start merging appropriate
things from the linuxppc_2_4_galileo tree on source.mvista.com into
2_4_devel.

The first thing I'm going to do is a moderately large cleanup to
drivers/net/gt64260_eth.c.

The second thing is to check in the drivers/char/gt64260_mpsc.c driver
originally from Zuma networks. This driver is reasonably well written, and
actually works on SMP.

There may be a few other relatively minor things later.

So, if you are actually using _devel and the 64260 ethernet driver, speak
up now.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

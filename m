Message-ID: <37DDC204.22888BE8@chpc.utah.edu>
Date: Mon, 13 Sep 1999 21:33:24 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: stty < /dev/modem blocks???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On my 2.2.12 kernel with some hacks I've added I can't use stty to get
the configuration info for /dev/ttyS0. stty < /dev/ttyS0 (aka
/dev/modem) just hangs. strace stty < /dev/ttyS0 does the same thing.
strace doesn't even show me any output. Ctrl-C kills the stty or strace
but shouldn't stty work on the modem serial device to get the config
info? Is it just the hacks I've added in my kernel perhaps? stty
< /dev/pts/0 works just fine. Ideas?

Thanks!!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

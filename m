Date: Thu, 23 Nov 2000 03:31:08 -0800
From: Avery Pennarun <apenwarr@worldvisions.ca>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: daenzerm@student.ethz.ch,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
Message-ID: <20001123033108.B13703@worldvisions.ca>
References: <20001123030808.A13371@worldvisions.ca> <Pine.LNX.4.10.10011231212270.18581-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10011231212270.18581-100000@zirkon.biophys.uni-duesseldorf.de>; from schmitz@zirkon.biophys.uni-duesseldorf.de on Thu, Nov 23, 2000 at 12:15:32PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 23, 2000 at 12:15:32PM +0100, Michael Schmitz wrote:

> Re: mounting /etc readonly: how do you handle /etc/mtab in that case? :-)

Symlink it to /proc/mounts, of course. :)

/etc/mtab has always been evil, and not just because it's in the wrong
directory.  It's about equivalent to the "route" or "ipchains" commands
keeping track of what _they_ thought the kernel settings were, and then if
you tried to list the routes or firewall rules, they would just cat the
file.  Yuck.

Have fun,

Avery

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

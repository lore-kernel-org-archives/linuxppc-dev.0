Date: Thu, 23 Aug 2001 09:58:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-benh0 problems and kudos
Message-ID: <20010823095805.I14302@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010823164256.8751.qmail@kunk.jriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010823164256.8751.qmail@kunk.jriver.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 23, 2001 at 11:42:56AM -0500, Robert E Brose II wrote:

> On the positive side it looks like the 7500 chaos PCI bus fixes
> have been incorporated as well as the planb fixes and the
> controlfb enhancements.

If you have planb, please fix this and try it out. :)

> Next, when pppoe, ax25 or netrom are compiled as modules, trying to
> insmod them gives the following...

Don't use insmod.  Use modprobe.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

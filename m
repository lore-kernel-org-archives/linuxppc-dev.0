Message-ID: <20010823194337.10575.qmail@kunk.jriver.com>
Subject: Re: 2.4.9-benh0 problems and kudos
In-Reply-To: <20010823095805.I14302@cpe-24-221-152-185.az.sprintbbd.net>
 "from Tom Rini at Aug 23, 2001 09:58:05 am"
To: Tom Rini <trini@kernel.crashing.org>
Date: Thu, 23 Aug 2001 14:43:37 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Tom Rini says:
> On Thu, Aug 23, 2001 at 11:42:56AM -0500, Robert E Brose II wrote:

> > Next, when pppoe, ax25 or netrom are compiled as modules, trying to
> > insmod them gives the following...
>
> Don't use insmod.  Use modprobe.
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

#/sbin/modprobe pppoe
/lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: unresolved symbol sk_run_filter
/lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: insmod /lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o failed
/lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: insmod pppoe failed

Same thing with respect to sk_run_filter


Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

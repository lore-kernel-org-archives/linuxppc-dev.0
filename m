Subject: 4xx users: Big merge party now
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>, Matt Porter <porter@cox.net>
Content-Type: text/plain
Message-Id: <1047493719.789.29.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 12 Mar 2003 19:28:39 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All interested 4xx users, especially board maintainers, here's
what's going on with 4xx now.

I rewrote the core OCP stuff. It's much more like 2.5 (actually,
some changes I did will be pushed to 2.5 as well, like static
indexes). It's documented in the source. I hope it should clean
some of the worst horrors with #ifdef's and previous ocp_dev
confusion (was it a device or a driver ?)

HOWEVER, I only ported ibm405gp.c to the new table format, please
use it as an example to port other CPUs. I also only ported the
EMAC driver to the new core. It's actually a mostly rewritten
driver with working PHY support and other niceties.

Also, please use what I did for EMAC and MAL channel mapping as
an example on how to avoid hard-coding numbers with #ifdef's and
feel free to add some similar 'additions' structures for other
OCP drivers. (In 2.5, the additions might be filled differently
in the future)

The tree is at ppc.bkbits.net/linuxppc-2.4, it's a clone of
Marcelo's linux-2.4, NOT of linuxppc_2_4_devel, the intend is
to push that to marcelo as soon as enough board maintainers will
have tested & fixed the remaining CPU OCP tables and drivers.

I'm of course open to comments :)

Have fun !

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: gopi@india.tejasnetworks.com
Date: Fri, 31 Jan 2003 14:22:15 +0000 (GMT)
To: Allen Curtis <acurtis@onz.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: mpc 8260 performance..
In-Reply-To: <NCBBIINEHIPFGJPLBEIFKEKDEBAA.acurtis@onz.com>
Message-ID: <Pine.LNX.4.21.0301311412001.21680-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


interfaces: hdlc interfaces (external hdlc controller connected to 8260 which
            can write to SDRAM directly.  Hence 8260 wont be involved in packet copying).

routing:
                             +------------+
                  Ethernet   | 8260 based |hdlc
External world <===========> | embedded   |----- 40 systems
                             | system     |-----
                             |            |-----
                             +------------+

As you can see, the systems on hdlc are connected to external world
through the 8260 based embedded system.

At peak, 8260 will have to get/send of all the hdlc interfaces and
route them to external world over ethernet.

my main concern was that, at peak, what would be the 8260 resources usage.

hope this clarifies
thanx
gopi

PS: Please note that we are not trying to build a full fledged router.
It is only a means of reaching the right side systems from the
external world.

On Fri, 31 Jan 2003, Allen Curtis wrote:

> >   We are planning to use 8260 for our embedded system.  One of the
> >   job is to do routing of around 40 interfaces, with each interface
> >   at about 500Kbps duplex.
>
> What kind of interfaces? What kind of routing?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

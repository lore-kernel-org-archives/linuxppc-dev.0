In-Reply-To: <1088085327022.mikko.alutoin.17388.vROgRbiXwfx6jgnkf5FAxQ@luukku.com>
References: <1088085327022.mikko.alutoin.17388.vROgRbiXwfx6jgnkf5FAxQ@luukku.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <85234FE8-C60D-11D8-9586-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: On the MPC85xx development boards
Date: Thu, 24 Jun 2004 14:37:17 -0400
To: Mikko Alutoin <mikko.alutoin@luukku.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jun 24, 2004, at 9:55 AM, Mikko Alutoin wrote:


> 4)	Silicon Tx GP3 8560

Having done the development of this board, I can tell you quite a
bit about it.

This is an "ODM" board, which means it comes with useful software
in some vertical markets.  It's purpose is to be quickly functional
as a product prototype, so the board size, connectors and options
are designed for more than just software development.  It is available
today with an 8541, 8555, or 8560 processor, there are other
board variations to be announced soon.

RPC Electronics is providing low volume manufacturing of custom
variations of these boards to meet product introduction schedules.
They are also able to work with other manufacturers, provide parts
kits, or whatever is necessary to minimize development resources
and expedite product deployment.

> I am under the impression that 1, 2, 4 and 5 (but not 3) come with a
> Linux BSP included? Is this correct?

Embedded Edge is providing the software which includes U-boot, Linux
2.4.26,
a small distribution, and an SPE enabled version of gcc 3.3.3 with
binutils.
The board comes with a kernel and file system in flash, upon power up
will
autoboot Linux and configure the network for remote access.  Unless you
are doing kernel development, all you need to do is log in an mount an
NFS file system to start your application development.

> Let us assume that the final product will not be based on a commercial
> Embedded Linux distro, but a custom 2.6 kernel with busybox & uclibc.
> Should that effect the choice in any way?

We are working with Freescale to get the 2.6 work merged into the
kernel,
so that will be available shortly for downloading.  I'm not a big fan
of busybox,
but people have been asking so a version of that and uclibc will also be
available once we get the 2.4/2.6 and glibc tools stable.

> Forgive me if the questions seem a bit foolish. The bottom line is
> that I have not used any kind of development boards in the past and I
> would like to receive some insight on which one of the above to
> choose.

It's more than choosing a board.  An Original Design Manufactuerer (ODM)
provider is more than just a board.  It's all about providing the
structure that
will minimize your resource investment and expediting your product
development.

Have fun!


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

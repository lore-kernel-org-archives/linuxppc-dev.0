Date: Wed, 31 Oct 2001 16:26:02 +0100
From: Bernhard Reiter <bernhard@intevation.de>
To: debian@jones.dk
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Debian] Irda can work
Message-ID: <20011031162602.A24896@intevation.de>
References: <20011031145005.L22319@intevation.de> <Pine.LNX.4.33.0110311520150.10525-100000@auryn.jones.dk>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0110311520150.10525-100000@auryn.jones.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 31, 2001 at 03:24:31PM +0100, Jonas Smedegaard wrote:
> and btw: I recommend kernel from BenH from 30/10 - it runs flawlessly on
> my machine, and has ide performance optimizations it seems (but don't know
> if it is TiBook related though)

We have some problems with DMA on BenH's kernel from yesterday (30.10.2001),
(maybe we've got it later).

Same problem with as described in
http://lists.linuxppc.org/linuxppc-dev/200110/msg00371.html

Anybody know what is causing this problem or how to get an older,
but more stable BenH tree without it?
	Bernhard
ps.: cc to linuxppc-dev, though I am not on the linuxppc-dev list,
	please cc relecant replies.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

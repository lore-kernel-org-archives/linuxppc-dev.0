Date: Sun, 23 Sep 2001 03:14:39 -0400 (EDT)
From: patrick <tendim@tendim.cjb.net>
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
In-Reply-To: <p05100300b7d31fabc70d@[10.0.0.42]>
Message-ID: <Pine.LNX.4.21.0109230313420.1883-100000@cr242184-a.etob1.on.wave.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 22 Sep 2001, Timothy A. Seufert wrote:

> You could always give up and connect sdb to your 2940UW's internal
> 50-pin connector instead of mesh.  (only half joking -- I'm under the
> impression that the mesh driver is not well maintained these days.)

I wish it were that easy.

I've just noticed that it not only MESH, but the Adaptec card as
well.  Which means the problem isn't limited to the driver (MESH or
Adaptec), and it isn't my own hardware (again, 2.2.x works fine).

Me thinks it is something to do with the Apple partition map support in
general.

--
patrick m pritchard
disposable hero.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

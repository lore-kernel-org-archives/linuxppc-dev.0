Date: Mon, 24 Jul 2000 10:01:25 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Josh Huber <huber@mclx.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: problems about __cli()
In-Reply-To: <20000724081959.B263@mclx.com>
Message-ID: <Pine.LNX.3.96.1000724100027.30780B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Jul 2000, Josh Huber wrote:

> On Sat, Jul 22, 2000 at 08:11:07PM +0200, Martin Costabel wrote:
> > There *are* situations where you need /usr/src/linux to point to your
> > current kernel sources. This is when you compile modules for the current
> > kernel, a prominent example being MOL.
>
> Actually, I prefer to add a -I/path/to/kernel/include to the module
> makefiles rather than the /usr/src/linux symlink. I suppose it's
> personal preference, but I find that having to explicitly specify
> where the kernel source is reduces the posibility of a screwed
> compile.

Moreover, your method Josh is the only sane method IMHO.  Trusting
/usr/src/linux to be correct for whatever kernel version you are
building against is Russian roulette (to put it lightly)...

	Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

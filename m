Date: Sat, 30 Oct 1999 10:07:36 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch
In-Reply-To: <381A6CF9.67FE83E2@wanadoo.fr>
Message-ID: <Pine.LNX.3.96LJ1.1b7.991030100042.1326A-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 30 Oct 1999, Martin Costabel wrote:

[...]
> Sorry to spoil the fun, but I personally feel that the linux kernel
> sources for the pmac are in a rather sorry state right now. Both the
> vger cvs and the samba rsync archives have gone into hibernation, and
> the kernel.org kernels just don't work. After having spent many hours

What about samba's linux-pmac-stable tree?  It's not exactly very stable,
but it compiles and boots just fine on 7600.

[...]
> There are a couple of other such problems (like the init/main.c that
> doesn't compile with initrd configured, probably some kind of weird
> Finnish humor), so that it took us hours to get one of these kernels to

IIRC, initrd support has been broken on all architectures.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

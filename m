Date: Mon, 24 Sep 2001 22:10:38 -0400 (EDT)
From: patrick <tendim@tendim.cjb.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting (SOLVED!)
In-Reply-To: <20010924150437.I14835@plato.local.lan>
Message-ID: <Pine.LNX.4.21.0109242208050.1127-100000@cr242184-a.etob1.on.wave.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Sep 2001, Ethan Benson wrote:

> its a debian modified version of pdisk thats more reliable.  get the
> one from debian woody.

Couldn't find it.

> > Perhaps it is pdisk that doesn't like the new kernel.
>
> i don't really see how.. its not doing much more then reading the
> first 32k of of the disk to parse the partition table.

Well, I feel stupid.

As Timothy verified, LinuxPPCQ4 pdisk doesn't like 2.4.x kernels, so I
upgraded to a new pdisk found at YellowdogLinux.com.  That let me see my
drives at least.

But I still couldn't mount.  I figured if pdisk was broken, mount might
be, so I upgraded to a newer version of mount from linuxppc.org.

*This* version gave me error messages I could read!  More importantly:

mount: filesystem hfs not supported by kernel

It would seem I turned off the experimental prompts in make menuconfig,
forgot about Apple HFS File System support, and blindly assumed that Apple
Partition Map support implied Apple HFS support.

D'oh.

Thanks for everyone's patience!


--
patrick m pritchard
disposable hero.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Marcus H. Mendenhall" <mendenmh@telalink.net>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: (more) 2.4 problems / G4/500/1GB dual processor / USB
Date: Fri, 1 Sep 2000 16:41:14 +0200
Message-Id: <20000901144114.29642@mailhost.mipsys.com>
In-Reply-To: <p04330100b5d563d5bdc6@[129.59.235.75]>
References: <p04330100b5d563d5bdc6@[129.59.235.75]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The kernel only recognizes 512MB of memory. I was hoping 2.4 would
>let me move beyond the 680 (or so) MB I can successfully access with
>the 2.2.17 linux-pmac-stable kernel.

Bitkeeper 2.4 has Paul's new high memory stuff (it's an option you need
to enable in the config). I don't know how well tested it is however.

>I get a series of PCI address conflicts when probing the PCI bus
>which result in my ethernet card not being able to be turned on. I am
>not using the built-in GMAC, but an older Apple 10/100 PCI card. This
>does not happen with the linux-pmac-stable kernel.

With recent kernels, GMAC works nicely. Several people (including me) are
working on solving those PCI problems.

>The USB mouse and keyboard are completely messed up (using the new
>input layer).  The mouse is frozen, and the keyboard returns
>(thoroughly) scrambled keycodes.   I noticed in a previous comment
>something about changing keycodes... is the setup completely
>different in 2.4?

Add "keyboard_sends_linux_keycodes=0" to your kernel command line to
force the input layer to use the old keycodes. Read Franz Sirl comments
on how to setup the new input layer, the mouse driver is no longer a
busmouse, but now provides PS2 datas to applications. You should find
links on my page (ppclinux.apple.com/~benh).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <bh40@calva.net>
To: Martin Costabel <costabel@wanadoo.fr>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patches for 2.4.0-test7
Date: Mon, 28 Aug 2000 11:34:49 +0200
Message-Id: <20000828093449.32188@192.168.1.10>
In-Reply-To: <39AA16ED.58CF5B8F@wanadoo.fr>
References: <39AA16ED.58CF5B8F@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>For the ADB *mouse*, this is quite different: When I want to use a
>kernel with the new input layer for the mouse, it is not sufficient to
>boot the correspondingly configured kernel. I also have to change a
>couple of files in /etc to tell about the new mouse driver, in my case
>
>/etc/devfsd.conf
>/etc/sysconfig/mouse
>/etc/X11/XF86Config
>
>Then I have to restart devfsd, rm /dev/mouse, and restart gpm. (In this
>order, and all this before starting X, of course).
>
>When I go back to a kernel without new input layer, I have to change all
>this back. This wouldn't be necessary if drivers for both /dev/adbmouse
>and /dev/input/mice could coexist..

Well, that's the reason why I originally wanted this compatibility code.
However, after more thinking, I figured out that if we do that, all it
will result is yet another configuration mess with users and more support
emails ;)

Note that you can have the new input layer with 2.2 using my kernels. I
still have to verify what's up with Vojtech, but I beleive the input
layer is part of the USB backport, meaning that future "kernel.org"
2.2s+backport will provide the same functionality as 2.4.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

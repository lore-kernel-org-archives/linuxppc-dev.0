Subject: Re: linuxppc-2.5 (rsync mvista) -- drivers/input/evdev.c:243:
	error: invalid lvalue in asm statement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308021823.30382.miles.lane@comcast.net>
References: <200308021823.30382.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1059902014.3519.86.camel@gaston>
Mime-Version: 1.0
Date: 03 Aug 2003 11:13:34 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-03 at 03:23, Miles Lane wrote:
>   CC      drivers/input/evdev.o
> drivers/input/evdev.c: In function `evdev_ioctl':
> drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> make[2]: *** [drivers/input/evdev.o] Error 1

Known bug, I'm waiting for Vojtech to push a proper fix

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sun, 9 Feb 2003 22:33:59 +0000
From: Magnus Damm <damm@opensource.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pmac: input layer as module and usb keyboard
Message-Id: <20030209223359.40b8c836.damm@opensource.se>
In-Reply-To: <1044829048.11918.4.camel@zion.wanadoo.fr>
References: <20030209213031.2b67933e.damm@opensource.se>
	<1044829048.11918.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > This patch makes it possible to use a usb keyboard with a kernel that has the
> > input layer compiled as a module.
> >
> > Please apply.
>
> Well, I tend to hate CONFIG_*_MODULE. The kernel itself shouldn't
> be affected by a subsystem or driver beeing a module that way. I
> need to find out a better way to deal with this problem.

I agree. But I like the idea of compiling the input layer as a module.
Maybe CONFIG_MAC_HID? Then we put the problem in config.in...

My local 2.4.20 pmac_setup.c has plenty of
#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
so you must be very happy.. =)

thanks.

/ magnus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

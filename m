Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Daniel Berlin <dan@cgsoftware.com>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Wed, 14 Nov 2001 16:54:54 -0500
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.33.0111141518370.25545-100000@www.cgsoftware.com> <20011114212415.18586@smtp.wanadoo.fr>
In-Reply-To: <20011114212415.18586@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <20011114215212.IFBL3045.tomts12-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I did some reading up on it and it seems to change the sync(?) signal to
simulate a serial line and pass 9 bit bytes (with parity?) which are
collected to form the EDID block.   Hopefully it won't be too complicated.

I don't understand if this is only done on monitor powerup or if it can be
done at any time by request or is it just sent continuously by the monitor.

Kevin




On November 14, 2001 04:24, Benjamin Herrenschmidt wrote:
> >No, I mean using i2c to grab it.
>
> I think OF uses the Radeon "GPIO" registers to probe the panel type
> based on a wired panel ID and a table of EDIDs in the driver. At least,
> it did it that way on mach64. I dumped a disassembly of the Rage M3
> (r128 base) MacOS 9 driver of my Pismo and started tracing it, it seem
> to play with GPIOs as well. I didn't yet figure out the exact algorithm
> though.
>
> Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Daniel Berlin <dan@cgsoftware.com>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Wed, 14 Nov 2001 23:14:03 +0100
Message-Id: <20011114221403.12088@smtp.wanadoo.fr>
In-Reply-To: <20011114215212.IFBL3045.tomts12-srv.bellnexxia.net@there>
References: <20011114215212.IFBL3045.tomts12-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I did some reading up on it and it seems to change the sync(?) signal to
>simulate a serial line and pass 9 bit bytes (with parity?) which are
>collected to form the EDID block.   Hopefully it won't be too complicated.
>
>I don't understand if this is only done on monitor powerup or if it can be
>done at any time by request or is it just sent continuously by the monitor.

What are you talking about ? Your DVI panel ? That's I2C, you have
one line doing the clock, one doing the data, there's some addressing
going on (first byte).

The Apple laptops _seem_ to be doing things differently. Unless you
figured something out I didn;t :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

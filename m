Date: Thu, 15 Nov 2001 01:04:48 -0500 (EST)
From: Daniel Berlin <dan@cgsoftware.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: DFP support for kernel radeonfb.c added
In-Reply-To: <20011115031058.IRIW10804.tomts19-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.33.0111142302580.13578-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Nov 2001, Kevin B. Hendricks wrote:
>
> Anyway, please give it a try.  I will send followup patches with other
> fixes and additions I make to improve things but this should be enough to
> get people working until the i2c stuff gets going.
>
> So Daniel, if you get a chance, please try this.  If it works, then we
> have broken nothing for you and we can then decide if you want to move to
> the more general case of using EDID info.  If it does not work, please let
> me know asap so I can back out my changes in groups until we identify what
> is going wrong here.

It works, but if i don't set the refdiv to 67 (like we do for the QD), i
get what looks like a very slow refresh rate (IE when you move the mouse
in X or cause a lot of screen updates on the console, you can see it's
going slower than it should).
I'll reboot a few times to verify this is indeed the cause.

> Thanks,
>
> Kevin
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

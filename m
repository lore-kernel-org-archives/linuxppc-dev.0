From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Berlin <dan@cgsoftware.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Wed, 14 Nov 2001 22:24:15 +0100
Message-Id: <20011114212415.18586@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0111141518370.25545-100000@www.cgsoftware.com>
References: <Pine.LNX.4.33.0111141518370.25545-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>No, I mean using i2c to grab it.

I think OF uses the Radeon "GPIO" registers to probe the panel type based
on a wired panel ID and a table of EDIDs in the driver. At least, it did
it that way on mach64. I dumped a disassembly of the Rage M3 (r128 base)
MacOS 9 driver of my Pismo and started tracing it, it seem to play with
GPIOs as well. I didn't yet figure out the exact algorithm though.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

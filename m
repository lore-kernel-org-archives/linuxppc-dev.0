Date: Wed, 14 Nov 2001 17:14:25 -0500 (EST)
From: Daniel Berlin <dan@cgsoftware.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: DFP support for kernel radeonfb.c added
In-Reply-To: <20011114212415.18586@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0111141713400.30166-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Nov 2001, Benjamin Herrenschmidt wrote:

>
> >No, I mean using i2c to grab it.
>
> I think OF uses the Radeon "GPIO" registers to probe the panel type based
> on a wired panel ID and a table of EDIDs in the driver. At least, it did
> it that way on mach64. I dumped a disassembly of the Rage M3 (r128 base)
> MacOS 9 driver of my Pismo and started tracing it, it seem to play with
> GPIOs as well. I didn't yet figure out the exact algorithm though.

Well, the GPIO's are used to control i2c as well (gpio 0 and 3, if i
remember right), so it might just be a red herring.


>
> Ben.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

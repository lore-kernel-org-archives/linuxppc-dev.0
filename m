From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Berlin <dan@www.cgsoftware.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 status
Date: Sat, 5 May 2001 15:50:08 +0200
Message-Id: <20010505135008.31470@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0105042358480.6265-100000@www.cgsoftware.com>
References: <Pine.LNX.4.33.0105042358480.6265-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>You can say whether you want the following swapped  or not (in any
>combination, they are just flags)
>
>1. selfid handling
>2. reading
>3. writing
>
>
>Pismo needs 2 and 3 to work right.
>Other OHCI on PPC (TI) need 1, 2, and 3.
>Your titanium probably needs 2 and 3, since i believe it's based on the
>uninorth, just a newer revision, right?

The titanium is the same logic board as the Pismo (well, almost). The
last TiPb I had a chance to play with had the exact same UniNorth revision
as the Pismo.

When you say you need byteswap on read & write, is this for data packets
read/written to/from memory (DMA) or is this for datas you feed to
(read from) a FIFO ? Just curious...

>It'll be on the 1394 list in about 10 minutes.

Is it against the 1394 CVS or will the current 2.4.4 1394 code work fine
with your patch as well ? In that later case, I'll include your patch in my
kernels.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

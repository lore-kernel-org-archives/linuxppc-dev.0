In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990930111227.23148D-100000@ofey.inetnebr.com>
Date: Thu, 30 Sep 1999 18:35:42 +0200
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
Message-Id: <19990930183542.004164@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 30, 1999, Takashi Oe <toe@unlserve.unl.edu> wrote:

>I suppose that can happen if DBDMA's FIFO wasn't flushed properly for
>some reason.  Do you know if the problem occurs on receiving side (from
>SCC to DMA) or transmitting side (from DMA to SCC)?  How many chars were
>garbled?  If the FIFO were the cause of the problem, the number should be
>between 1 and 7.

I don't know the details, it was quite a long time ago... I'll ask him again.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

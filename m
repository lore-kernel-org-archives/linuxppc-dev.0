From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: question on howto use invalidate_dcache_range
Date: Wed, 12 Mar 2003 12:20:06 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in November there was the discussion about Joakims patch to 8xx_io/enet.c.
(http://lists.linuxppc.org/linuxppc-embedded/200211/msg00122.html)

Since the result of the discussion didn't seam that clear to me I still have a question related to this.

After all is it realy neccessary to use invalidate_dcache range before giving the transmit buffer to the DMA?
  That's one of Joakims last modifications but what exactly is the reason? It's obvious for the flush command but I couldn't figure
out the reason for invalidate.
Beside the cache line alignment problem (causing nearby data to be flushed or invalidated) are there any other problems to be taken
care of?

Thanks, Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

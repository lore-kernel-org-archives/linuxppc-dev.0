Message-ID: <3E15CD9D.62110C6@midrivers.com>
Date: Fri, 03 Jan 2003 10:51:25 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: DMA and caches -- 'correct handling'?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


this is a ppc405 -based controller question but has bearing on
the right way to DMA under linux, in general:

I have an application in which I'll be DMAing several megabytes
from memory into a fifo;  the data are cpu-created so I'd expect
I'd need to flush the data cache prior to starting the DMA.

is this implicitly done by any of the setup & start-dma calls or
should I explicitly do this myself.

also, give the sizeof the source buffer and the smallness of the
405 data cache, I'd expect I should flush the entire cache to
memory (flush pending writes) rather than for the entire address
range of the source buffer.

thoughts?

thanks,

Mark

--
Mark Pilon
Minolta-QMS

P.O. Box 37
325 Dawson County Road 227
Fallon, MT.  59326-0037
1-406-486-5539 (primary voice line)
1-406-853-0433 (cell)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

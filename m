Message-ID: <38D2151B.A7A5E345@pop.agri.ch>
Date: Fri, 17 Mar 2000 12:20:59 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: insl/outsl alternatives??
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
in the 3c59x code I found insl and outsl commands. AFAIK they don't work
on ppc. But in misc.S insl/outsl & insl_ns/outsl_ns are implemented.
So I redefined in 3c59x.c the insl as insl_ns and the outsl as outsl_ns.
But this doesn't seem to work. (or only half way)

This is the line which is affected:

insl(ioaddr + RX_FIFO, skb_put(skb, pkt_len),(pkt_len + 3) >> 2);

Are the *_ns working correctly or do I have to pay attention to smthg.
else?

Are the in/outsl_ns equal to the i386 insl/outsl ?

Thanks

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

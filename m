To: greyham@research.canon.com.au (Graham Stoney)
Cc: dan@netx4.com (Dan Malek), linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC ERROR 41200000 on CLLF-860T
References: <19991209002442.41D86118CD@elph.research.canon.com.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 09 Dec 1999 12:18:52 +0100
In-Reply-To: greyham@research.canon.com.au's message of "Thu, 9 Dec 1999 11:24:42 +1100 (EST)"
Message-ID: <kfyr9gwz7j7.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


greyham@research.canon.com.au (Graham Stoney) writes:

> Dan Malek writes:
> > The drivers are changing to accomodate all of these things.
> 
> Sounds great; I'd be interested in testing an update whenever it's doable.
> 
> > The SCC Ethernet on a 50 MHz 860 can easily maintain the theoretical network
> > limits between 8 and 9 Mbit/sec with the TCP/IP stack.
> 
> We're using the FEC exclusively, and I'm hoping for a similar story at around
> 8 Mbytes/sec with the TCP/IP stack.

Well, that you can probably forget. :-(
Using a program that sends 1500 bytes udp packets as fast as it
can we get 22-23 Mbit throughput (50MHz 860T).
On vxworks the same program gives about 27 Mbit throughput, and
Windriver claims this is a limitation in the hardware...

(Our PII server connected to the same hub gives about 91 Mbit)

//Marcus
-- 
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Subject: TCP/IP performance on the 855T/860T
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Fri, 30 Jun 2000 11:33:09 +1000 (EST)
In-Reply-To: <395B9171.76934B4E@netx4.com> from "Dan Malek" at Jun 29, 2000 02:12:01 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000630013309.7F172BB@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> The bottleneck is the protocol and application processing in the PPC core.

So has anyone had a chance to look at where exactly in the TCP/IP stack the
bottleneck is since this was last discussed?  Surely a 50 MHz part with an
on-chip 100 Mbps Ethernet controller has enough grunt to keep up with a single
TCP/IP connection.

> Just write a program (nttcp works) to benchmark using the local
> loopback device.  That will tell you what the processor can
> accomplish.

Thanks for the suggestion. I ran my tcp test through the loop device on the
50 MHz 860T CLLF board, and it gives a little over 4 Mbytes/sec. So Dan's
absolutely right as usual; the problem isn't in the FEC, it's in the protocol
stack. Somewhere. Any suggestions?

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

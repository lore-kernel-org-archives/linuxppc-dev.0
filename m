Message-ID: <395C0759.9C8A6C83@netx4.com>
Date: Thu, 29 Jun 2000 22:35:05 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: TCP/IP performance on the 855T/860T
References: <20000630013309.7F172BB@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> So has anyone had a chance to look at where exactly in the TCP/IP stack the
> bottleneck is since this was last discussed?

Yes, you can do a few things with TCP/IP windows to help a little,
but it is only a few percent.

> ....  Surely a 50 MHz part with an
> on-chip 100 Mbps Ethernet controller has enough grunt to keep up with a single
> TCP/IP connection.

There isn't any other processor that will do it at that speed.
Dig out an old 486 and try the local loopback test......You wouldn't
be surprised if it can't keep up.

>  Any suggestions?

...8260....



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

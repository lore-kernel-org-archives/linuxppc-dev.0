Subject: Re: FEC ERROR 41200000 on CLLF-860T
To: dan@netx4.com (Dan Malek)
Date: Tue, 7 Dec 1999 18:05:38 +1100 (EST)
Cc: greyham@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <384CAF1B.1C6CFE3@netx4.com> from "Dan Malek" at Dec 7, 99 01:54:19 am
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991207070538.5A4B9118F0@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> Oh yes.....I don't have the FEC driver updated for that board
> yet.  Although my instructions tell you how to download through
> that port and get the CLLF utility program to initialize it
> because I have been too lazy, something still isn't quite
> right.

I've got the kernel to boot thanks to your instructions, and it does keep
running after the error appears. I notice that the fec driver in the 2.3.18
kernel is a little different, but I haven't managed to get that kernel to run
at all yet, so I'm hanging with 2.2.13 at least for now.

> If it appears to be working, then just keep smiling and go
> on about your business.  Don't try any performance tests.......

Hmmm... performance tests are something I'm thinking about trying pretty soon!

> That particular error looks legitimate.  Probably some kind
> of a hard network error.  Since the buffer wasn't marked as +last,
> it looks like someone is jumping on the bus with late collisions
> or something.  How often does it occur?

Every couple of minutes or so; it seems to happen most during NFS traffic. I
haven't really hunted it hard yet though.

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

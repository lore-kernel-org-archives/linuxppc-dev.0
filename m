Message-ID: <384CAF1B.1C6CFE3@netx4.com>
Date: Tue, 07 Dec 1999 01:54:19 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC ERROR 41200000 on CLLF-860T
References: <19991207064156.5D9DF118D3@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


>     FEC ERROR 41200000
>     FEC ENET: rcv is not +last
> 
> Is this something I should be worried about?


Oh yes.....I don't have the FEC driver updated for that board
yet.  Although my instructions tell you how to download through
that port and get the CLLF utility program to initialize it
because I have been too lazy, something still isn't quite
right.

If it appears to be working, then just keep smiling and go
on about your business.  Don't try any performance tests.......

That particular error looks legitimate.  Probably some kind
of a hard network error.  Since the buffer wasn't marked as +last,
it looks like someone is jumping on the bus with late collisions
or something.  How often does it occur?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

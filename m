Date: Tue, 21 Sep 1999 22:10:44 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Compiling 2.3.18
In-reply-to: <37E83203.D830C221@netx4.com>
To: Dan Malek <dan@netx4.com>
Cc: Dan Malek <dan@penguin.netx4.com>, linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9909212200360.1558-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




I am not sure I understand your question, but I'll try my
best to answer it.

I want to build a minimal kernel for a target that only has
an MPC860 with an SMC based console and a 10BaseT Enet,
pretty much like the fads.

I do not know which board type is the closest but I know that
the MBX is way too complex (the resulting kernel image will
certainly be bigger than necessary). Originaly, anyway, I was
not even able to make dep with the mbx target (which I think is
your preferred target), probably this is due to the minimalist
configuration (as lean as possible) I am using.

So, I am building using the 2.3.18 sources I found in the
embedded linuxppc.cs.nmt.edu using a stock pmac (7300) with
2.2.10

Can you send me a known working .config file, I've overwritten
the one that came with the tar file.


Claude


On Tue, 21 Sep 1999, Dan Malek wrote:

> 
> Claude Robitaille wrote:
> 
> > Is it ok to move the mpc8xx.h inclusion statement earlier in the
> > irq.h file? Is there a reason for it to be late in the file?
> 
> I guess I need to ask what you are building and with what kernel.
> The current file configuration seems to work fine with all of the
> other boards.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

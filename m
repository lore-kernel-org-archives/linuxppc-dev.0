Date: Wed, 27 Oct 1999 21:24:08 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Still not booting
In-reply-to: <3814DCF8.D74828C0@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910272123320.9536-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I works now, thanks Dan

On Mon, 25 Oct 1999, Dan Malek wrote:

> 
> Claude Robitaille wrote:
> 
> 
> > ..... Right now, I find that the first
> > access to the memory to clear it ends up in hanging the system. The
> > address is 3004ddcc which obviously seems to be a logical or virtual
> > address.
> 
> 
> What are you using for the addresses of the IMMR, control registers
> and such?  You can't use the default values that most debuggers
> stuff into a FADS board, these have to all be moved into the
> kernel virtual address space, which map 1:1 to their
> corresponding physical address, and requires properly programming
> the memory controller and changing the debugger scripts.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

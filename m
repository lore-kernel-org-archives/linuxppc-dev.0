Message-ID: <37FCB8B5.99B0A564@media.mit.edu>
Date: Thu, 07 Oct 1999 11:13:57 -0400
From: Robert Poor <r@media.mit.edu>
Reply-To: r@mit.edu
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx/Linux boards
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.  I'm researching {wireless distributed decentralized} networking
protocols[*].  Not content just to run simulations, I want to validate 
the algorithms on real hardware.  I'll need a couple dozen boards with
embedded processors onto which I'll glue a short-range RF transceivers
and test my stuff.

My first choice for platform is Linux (fast development cycle) running
on an MPC823 board (easy to make a gateway to 10BaseT).  So I'm hunting 
for the "best" development platform.

"Best" in this case essentially means "fastest development cycle".  
Cost is less of an issue, but since I'll need several dozen boards, 
the price must be reasonable.  Low power and small size is good.

I'm familiar with the BSE boards.  They're expensive, and I certainly
don't need the I/O FPGA, but that's a starting point.  If need be, I
could fab boards myself (I'm already doing the RF subsystem), but I'd
want to start with a well tested reference design, and even then only
if it's designed around readily available parts.  (Raise your hand if
you've built hardware before... :)

But I'd rather purchase something off the shelf.  Recommendations?
Pointers?  Thanks...

- Rob Poor
  MIT Media Lab

[*] for the curious, see
    http://www.media.mit.edu/~r/projects/embedded/index.html

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

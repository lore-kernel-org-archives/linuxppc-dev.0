Message-ID: <38DFAD63.3D937773@embeddededge.com>
Date: Mon, 27 Mar 2000 13:50:11 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steven Hein <ssh@sgi.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc.kernel.org problems
References: <38DA36A3.3A384DD7@sgi.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Hein wrote:

> I'm working on a MBX-based 860T board, and I'd like to move from the
> 2.2.13 kernel in the HardHat package to the latest 2.3.x kernel.
> (We need it for the USB drivers).

I am working on the 2.3.xx kernel right now.  There have been lots of
generic changes that need integration for 8xx.  Keep looking at the
tree over the next few days, it should come together.

> I have BitKeeper access and I grabbed the latest Linux/PPC kernel tree,
> but it doesn't have updated FEC or UART drivers in arch/ppc/8xx_io,

That should have all been there last week......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

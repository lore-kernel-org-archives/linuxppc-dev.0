Date: Wed, 28 Feb 2001 20:07:56 -0500
From: Konstantin Olchanski <olchansk@ux1.phy.bnl.gov>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem requesting IRQ with 2.4.2 kernel
Message-ID: <20010228200756.E252@ux1.phy.bnl.gov>
References: <200102280559.XAA05414@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200102280559.XAA05414@lists.linuxppc.org>; from owner-linuxppc-dev-digest@lists.linuxppc.org on Tue, Feb 27, 2001 at 11:59:28PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Date: Tue, 27 Feb 2001 17:56:53 +0100
> From: xav <grave@ipno.in2p3.fr>
> Subject: Problem requesting IRQ with 2.4.2 kernel
>
> Hi !
>
> I'm using a clone of the bk tree to compile a 2.4.2 kernel.
> I have also downloaded the code from Gabriel Paubert for the
> pci2vme chip from TUNDRA.
>


I see the same problem- on my kernels (older bitkeeper 2.4 tree)
pdev->irq comes out as zero.

By experimenting, I determined (and hardwired into the driver)
a working Universe irq on the MVME230x: "11".

I do not know how to kludge the "prep" routing tables- none of the
numbers in those tables match the board and vxworks BSP documentation.

I guess this will be ultimately fixed by Matt Porter's new MVME support
in the 2.5 tree.


--
Konstantin Olchanski
Physics Department, Brookhaven National Laboratory, Long Island, New York
olchansk@bnl.gov

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

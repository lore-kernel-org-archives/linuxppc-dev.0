Message-ID: <3BD74F42.E7A25537@corelatus.com>
Date: Thu, 25 Oct 2001 01:31:14 +0200
From: Thomas Lange <thomas@corelatus.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: Jeremy Rosen <Rosen.Jeremy@tms-pty.com>
Subject: Re: MPC8xx IDE
References: <sbd7c48d.025@tms-pty.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


IDE0_INTERRUPT specifies which irq level that should be used in
the cpm for pcmcia. It is written into register pgcr.

You should be safe using the same as other boards unless you
already are using that irq level for something else.

/Thomas

Jeremy Rosen wrote:
>
> Yes, I am also trying to have pcmcia to work on my FADS board...
> it is already configured in the denx kernel for the following boards
> ivms8,lwmon.spd8xx,tqm8xx
>
> to have it, it seems (havn't investigated deeply yet ) that their are
> just a couple of #define to add...
> most of them are common to all board, but one of them is giving me
> serious problems : IDE0_INTERRUPT
> I tried to find out in my boards documentation what interrupt was to be
> assigned to pcmcia, but I didn't find...
> did I miss something ???
>
> >>> Laurent Pinchart <laurent.pinchart@capflow.com> 10/24/01 10:47PM
> >>>
>
> Hi
>
> While trying to find an easy way to add non-volatile storage on a
> custion MPC860 board, I noticed that there was some support for IDE on
> the PCMCIA interface in the Linux kernel.
>
> Does anyone know where I can find more information about that ? There
> seems to be a board (IVMS8) with such an IDE interface, but I haven't
> been able to find anything about it on the web.
>
> Laurent Pinchart
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

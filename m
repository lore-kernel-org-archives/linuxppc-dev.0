Message-ID: <3BBB803E.63B9239@mvista.com>
Date: Wed, 03 Oct 2001 14:16:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Prasad, Siva" <Siva.Prasad@smartm.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: EPIC <=> OpenPIC
References: <35C119252057D511BB9F0003476BF8A208E5DB@freexc01.smartm.com> <3BBB7DB6.7BD2C503@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:

> "Prasad, Siva" wrote:
>
> > Hi,
> >
> > Is there code written or ported to EPIC (Embedded programmable interrupt
> > controller - MPC 107)?.
>
> Yes, mpc10x_common.c.  Examples of its use are in the code.

I'll add a little more.  You can use the openpic code with the EPIC if you're
careful.  Look at sandpoint_setup.c for an example.  Your EPIC IRQs *must*
start at 16 and resist the urge to set the offset param to anything but 0.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

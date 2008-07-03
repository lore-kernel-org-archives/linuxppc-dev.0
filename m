Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE006.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 35A34DDF5C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 23:20:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] powerpc: Xilinx: add 440 platform support
Date: Thu, 3 Jul 2008 07:20:45 -0600
In-Reply-To: <20080703091448.4e298ce8@zod.rchland.ibm.com>
References: <20080701224829.EC51111E8013@mail35-sin.bigfish.com>
	<20080703091448.4e298ce8@zod.rchland.ibm.com>
From: John Linn <John.Linn@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-ID: <20080703132047.62AA8A20055@mail137-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

XILINX_VIRTEX_5_FXT is the FPGA architecture, which has a 440 and can be
on a number of different boards.

Thanks,
John

> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com]
> Sent: Thursday, July 03, 2008 7:15 AM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca; John Linn
> Subject: Re: [PATCH] powerpc: Xilinx: add 440 platform support
> =

> On Tue, 1 Jul 2008 15:48:26 -0700
> John Linn <john.linn@xilinx.com> wrote:
> =

> > Support for the Xilinx Virtex5 FXT 440 is being
> > added.
> >
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > ---
> >  arch/powerpc/platforms/44x/Kconfig  |   25 ++++++++++++++
> >  arch/powerpc/platforms/44x/Makefile |    1 +
> >  arch/powerpc/platforms/44x/virtex.c |   60
+++++++++++++++++++++++++++++++++++
> >  3 files changed, 86 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/powerpc/platforms/44x/virtex.c
> >
> > diff --git a/arch/powerpc/platforms/44x/Kconfig
b/arch/powerpc/platforms/44x/Kconfig
> > index 6abe913..84eb847 100644
> > --- a/arch/powerpc/platforms/44x/Kconfig
> > +++ b/arch/powerpc/platforms/44x/Kconfig
> > @@ -102,6 +102,22 @@ config YOSEMITE
> >  #	help
> >  #	  This option enables support for the IBM PPC440GX evaluation
board.
> >
> > +config XILINX_VIRTEX440_GENERIC_BOARD
> > +	bool "Generic Xilinx Virtex 440 board"
> > +	depends on 44x
> > +	default n
> > +	select XILINX_VIRTEX_5_FXT
> =

> If this is for generic Virtex 440 board support, why is it selecting a
> specific Virtex 5 board?  Or am I confused as to what
> XILINX_VIRTEX_5_FXT is?
> =

> josh


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

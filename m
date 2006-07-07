Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 69ED767B5D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jul 2006 19:29:37 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k679TZ0g016403
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Jul 2006 02:29:35 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k679TXfP022478
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Jul 2006 04:29:35 -0500 (CDT)
Subject: RE: SIU_INT_IRQ4 in MPC 8260
Date: Fri, 7 Jul 2006 17:31:57 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <4879B0C6C249214CBE7AB04453F84E4DF27E@zch01exm20.fsl.freescale.net>
In-Reply-To: <8C86FBE3C676D29-1D1C-33C6@FWM-D43.sysops.aol.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <jagannathanjay@aim.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Interrupt is signal sending from external devices to CPU notifying
something has happened.  So if you want your interrupt handler be
called, first you have to make sure the device does send such signals.

Best Regards,
Leo
> -----Original Message-----
> From: jagannathanjay@aim.com [mailto:jagannathanjay@aim.com]
> Sent: Friday, July 07, 2006 5:24 PM
> To: Li Yang-r58472
> Subject: Re: SIU_INT_IRQ4 in MPC 8260
>=20
> No I haven't measured the IRQ4 line
>=20
> I am newbie into MPC8260 .
>=20
> Can u guide me as to what way I should proceed to get my interrupt
> handler working?
>=20
> Regards
> Jagan
>=20
>=20
>=20
> -----Original Message-----
> From: Li Yang-r58472 <LeoLi@freescale.com>
> To: jagannathanjay@aim.com; linuxppc-embedded@ozlabs.org
> Sent: Fri, 7 Jul 2006 17:18:54 +0800
> Subject: RE: SIU_INT_IRQ4 in MPC 8260
>=20
>    Are you sure the IRQ4 line is generating irqs?  Did you measure the
> line
> using an oscilloscope?
>=20
> Best Regards,
> Leo
> > -----Original Message-----
> > From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> > [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] =
On
> Behalf
> > Of jagannathanjay@aim.com
> > Sent: Friday, July 07, 2006 5:05 PM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: SIU_INT_IRQ4 in MPC 8260
> >
> > Hi all
> >
> > I am trying to set up a interrupt handler for SIU_INT_IRQ4.
> >
> > The target I am using is MPC 8260 , emmbedded planet Evaluation
board.
> >
> > The OS is Embedded Linux .
> >
>
------------------------------------------------------------------------
> -
> > ------------
> > void my_interrupt_handler(int irq, void *dev_id, struct pt_regs
*regs)
> > {
> >
> >  printk("***********
> ");
> >
> > }
> >
> >
> >  if( request_irq(SIU_INT_IRQ4,my_interrupt_handler,0,0,0) < 0)
> >  {
> >      printk("
>  unable to register the interrupt handler
> ");
> >  }
> >
> >
>
------------------------------------------------------------------------
> -
> > ------------
> >
> > But my_interrupt_handler isn't getting called .
> >
> > Can anyone help me to fix this problem
> >
> > Regards
> > Jagan
> >
> >
> >
> >
> >
> >
>
________________________________________________________________________
> > Check Out the new free AIM(R) Mail -- 2 GB of storage and
> > industry-leading spam and email virus protection.
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
>
________________________________________________________________________
> Check Out the new free AIM(R) Mail -- 2 GB of storage and
> industry-leading spam and email virus protection.

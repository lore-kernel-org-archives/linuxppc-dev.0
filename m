Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id EACC167B70
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jul 2006 19:16:34 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k67AXkCI001039
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Jul 2006 04:33:46 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k679GVbp017263
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Jul 2006 04:16:32 -0500 (CDT)
Subject: RE: SIU_INT_IRQ4 in MPC 8260
Date: Fri, 7 Jul 2006 17:18:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <4879B0C6C249214CBE7AB04453F84E4DF27A@zch01exm20.fsl.freescale.net>
In-Reply-To: <8C86FBB9DCF99D2-1D1C-336A@FWM-D43.sysops.aol.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <jagannathanjay@aim.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Are you sure the IRQ4 line is generating irqs?  Did you measure the line
using an oscilloscope?

Best Regards,
Leo
> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf
> Of jagannathanjay@aim.com
> Sent: Friday, July 07, 2006 5:05 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: SIU_INT_IRQ4 in MPC 8260
>=20
> Hi all
>=20
> I am trying to set up a interrupt handler for SIU_INT_IRQ4.
>=20
> The target I am using is MPC 8260 , emmbedded planet Evaluation board.
>=20
> The OS is Embedded Linux .
>
------------------------------------------------------------------------
-
> ------------
> void my_interrupt_handler(int irq, void *dev_id, struct pt_regs *regs)
> {
>=20
>  printk("*********** \n");
>=20
> }
>=20
>=20
>  if( request_irq(SIU_INT_IRQ4,my_interrupt_handler,0,0,0) < 0)
>  {
>      printk("\n unable to register the interrupt handler \n");
>  }
>=20
>
------------------------------------------------------------------------
-
> ------------
>=20
> But my_interrupt_handler isn't getting called .
>=20
> Can anyone help me to fix this problem
>=20
> Regards
> Jagan
>=20
>=20
>=20
>=20
>=20
>
________________________________________________________________________
> Check Out the new free AIM(R) Mail -- 2 GB of storage and
> industry-leading spam and email virus protection.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

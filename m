Return-Path: <jianfei616@hotmail.com>
Message-ID: <BAY113-F3356266D183487A457F1AE988F0@phx.gbl>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673026FD94A@zch01exm40.ap.freescale.net>
From: "Guo Jaffe" <jianfei616@hotmail.com>
To: DaveLiu@freescale.com
Subject: RE: does Gianfar Ethernet Controller Version 1.1 support MARVELL
	88E1111?
Date: Mon, 12 Jun 2006 15:34:01 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dave,

"Do you have a low reset pulse to PHY before pull up the RSTn?"
Yes, I do.

>From: Liu Dave-r63238 <DaveLiu@freescale.com>
>To: "'Guo Jaffe'" <jianfei616@hotmail.com>,        Fleming Andy-afleming 
<afleming@freescale.com>
>CC: Linuxppc-embedded@ozlabs.org
>Subject: RE: does Gianfar Ethernet Controller Version 1.1 support MARVELL 
88E1111?
>Date: Mon, 12 Jun 2006 12:46:15 +0800
>
> >
> > The PHY ID I read is MARVELL 88E1101(1410cc2)
> >
>The MDIO bus is working well, the 88E1101's ID is 1410c6x,
>the 88E1111 is 1410ccx.
>
> > Today I took the MPC 8540 off the board, and checked the two
> > GMII phy chips
> 
> alone. I manually pulled up the phys's RST pins when the cable was in
> > position. But the link LED still can't light up. So it turned
> > out not the
> > driver's problem.
> >
>Do you have a low reset pulse to PHY before pull up the RSTn?
>
> > The hardware configuration of 88E1111 is GMII to copper, Auto-Neg,
> > advertise all capabilities, prefer Master.
> >
> > The PHY's power is correct and clean. And for interface
> > between TESC and
> > PHY I think even TESC power is set for 3.3V environment it
> > still can work
> > with the 88e1111 whose VDD is 2.5V. Because the datasheet of
> > 88e1111 says
> > that input pins are 3.3V tolerant. Am I right?
> >
>You are right.
>
>-Dave

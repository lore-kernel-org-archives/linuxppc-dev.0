Return-Path: <afleming@freescale.com>
In-Reply-To: <BAY113-F12840A9A3ACBD5515A1350988B0@phx.gbl>
References: <BAY113-F12840A9A3ACBD5515A1350988B0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <912A1A11-36AB-4E68-BC29-7F584270C4F0@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: does Gianfar Ethernet Controller Version 1.1 support MARVELL
	88E1111?
Date: Thu, 8 Jun 2006 11:15:32 -0500
To: =?UTF-8?B?6YOtIOWJkemdng==?= <jianfei616@hotmail.com>
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


On Jun 8, 2006, at 02:43, =E9=83=AD =E5=89=91=E9=9D=9E wrote:

> Hi all,
> I'm debugging my board with MPC 8540 and marvell 88e1111 designed =20
> on it.
> I'm sure the hardware connection is correct, and the phy's ID could =20=

> be read
> through terminal port. But anyway, phy can not work. I wonder if it =20=

> is the
> driver's problem? Since the Gianfar Ethernet Controller Version 1.1
> surpport 88e1011s, but some 88e1111's registers are different from
> 88e1011s'. Actually I'm a new guy to Linux. Has anybody ever used =20
> 88e1111
> phy in Linux envirenmemt? Please
> give me some points. Thank you!
> I have read the Gianfar ethernet controller driver, but it's =20
> difficult for
> me to find out the sofware flow.


It would be better if you upgraded to the latest kernel.  The PHY =20
subsystem in the driver has changed significantly since version 1.1 =20
of the driver.  What leads you to believe that the PHY doesn't work?  =20=

What errors do you see?  I'm fairly certain the 88e1111 works with =20
the 88e1011 driver, but it's been a while.

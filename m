Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53112.mail.yahoo.com (web53112.mail.yahoo.com
	[206.190.49.62]) by ozlabs.org (Postfix) with SMTP id 650E3DE0BE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Jan 2007 01:53:18 +1100 (EST)
Message-ID: <20070126145317.26311.qmail@web53112.mail.yahoo.com>
Date: Fri, 26 Jan 2007 06:53:17 -0800 (PST)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: RE: MPC8260 I2C Problem
To: Li Yang-r58472 <LeoLi@freescale.com>,
	embedded linuxppc <linuxppc-embedded@ozlabs.org>
In-Reply-To: <989B956029373F45A0B8AF0297081890087468@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am sure that I used i2c-mpc8260.c in the
drivers\i2c\busses folder, it is for mpc8260.

--- Li Yang-r58472 <LeoLi@freescale.com> wrote:

> You are talking about the wrong i2c driver.  For
> 8260, you need a cpm
> i2c driver, not the i2c-mpc driver.
> 
> - Leo
> 
> > -----Original Message-----
> > From:
>
linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org
> >
>
[mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org]
> On
> Behalf Of
> > jimmy liu
> > Sent: Friday, January 26, 2007 1:06 AM
> > To: embedded linuxppc
> > Subject: RE: MPC8260 I2C Problem
> > 
> > In the arch\ppc\syslib\pq2_devices.c, there has
> the
> > device descriptions.
> > Do I still need manually create the plateform bus
> > tree?
> > 
> > --- Li Yang-r58472 <LeoLi@freescale.com> wrote:
> > 
> > > > -----Original Message-----
> > > > From:
> > >
> >
>
linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org
> > > >
> > >
> >
>
[mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org]
> > > On
> > > Behalf Of
> > > > jimmy liu
> > > > Sent: Thursday, January 25, 2007 11:22 AM
> > > > To: embedded linuxppc
> > > > Subject: MPC8260 I2C Problem
> > > >
> > > > I download the linux kernel 2.6.19 from
> > > > ftp://ftp.denx.de/pub/linux/ site.
> > > >
> > > > When I add mpc8260 I2C driver to Linux kernel
> > > 2.6.19,
> > > > the init function looks like that
> > > > static int __init fsl_i2c_init(void)
> > > > {
> > > > 	return driver_register(&fsl_i2c_driver);
> > > > }
> > > > I set the debug on, and found that the
> > > fsl_i2c_probe()
> > > > function is never called, so there is not I2C
> > > device
> > > > enabled, and the user space function
> > > > open("/dev/i2c-0",O_RDWR) always return error.
> I
> > > set
> > > > something wrong? Could somebody help me?
> > >
> > > Do you have an fsl-i2c node in your device tree?
> > >
> > > - Leo
> > >
> > 
> > 
> > 
> > 
> >
>
________________________________________________________________________
> ______
> > ______
> > Don't pick lemons.
> > See all the new 2007 cars at Yahoo! Autos.
> > http://autos.yahoo.com/new_cars.html
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 




 
____________________________________________________________________________________
Need Mail bonding?
Go to the Yahoo! Mail Q&A for great tips from Yahoo! Answers users.
http://answers.yahoo.com/dir/?link=list&sid=396546091

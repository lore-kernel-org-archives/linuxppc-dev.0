Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.101.113.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2CD5067A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 16:52:28 +1000 (EST)
Received: from wip-ectls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id E90DD220126
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 12:23:01 +0530 (IST)
Received: from blr-ec-bh3.wipro.com (blr-ec-bh3.wipro.com [10.200.50.93])
	by wip-ectls-mx1.wipro.com (Postfix) with ESMTP id DAADA220116
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 12:23:01 +0530 (IST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 1 Apr 2005 12:26:52 +0530
Message-ID: <0BB9B22EEC2E8A4EBA4472D50DEA64B60D5DE8@HYD-MKD-MBX01.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <manisha.vj@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: custom board MPC8266
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


As per my experience if we set CONIG_SCC_CONSOLE =3Dy the SCC1 will be
used as serial console. Since we have connected serial console to SCC1,
it started working with the above option set.

Rgds
SS

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Manisha
Jagadhane
Sent: Friday, April 01, 2005 11:31 AM
To: Rune Torgersen; linuxppc-embedded@ozlabs.org
Subject: Re: custom board MPC8266

Thanks for the reply.=0D
I have seen the file arch/ppc/8260_io/commproc.c, but there is nowhere
given where to configure the SMC1/SMC2/SCC1/SCC2 as serial console. In
the .config file, whether we have to set CONFIG_SCC_CONSOLE=3Dy option
and in this .config file, is it required to do any configuration to
set SMC1 as serial console?

Please clarify.

Thanking you in advance.

Regards,
Manisha


On Mar 30, 2005 7:57 PM, Rune Torgersen <runet@innovsys.com> wrote:
> If I remember correctly: You have to edit the
> arch/ppc/82xx_io/commproc.c file (I think) to set up which serial port
> is used for console port.
>=0D
> > -----Original Message-----
> > From: linuxppc-embedded-bounces@ozlabs.org
> > [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of
> > Manisha Jagadhane
> > Sent: Wednesday, March 30, 2005 05:32
> > To: linuxppc-embedded@ozlabs.org
> > Subject: custom board MPC8266
> >
> > Hi,
> >
> > I am using custom board based on MPC8266 processor. I have
> > successfully ported U-Boot 1.1.1 on it. I have used SMC1 as serial
> > port in the board. Does the 2.4.24 kernel version for ppc supports
> > SMC1 as serial console? Which configuration I have to give in the
> > .config file to configure SMC1 as serial console? Which board's
> > defconfig file  shall I take as a reference and which kernel version
> > shall I use?
> >
> > Please help me in this regard.
> >
> > Thanking you in advance.
> >
> > Regards,
> >
> > Manisha.
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
>
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.

Return-Path: <manisha.vj@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id 3384967A7C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 16:00:31 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so593711wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 22:00:30 -0800 (PST)
Message-ID: <4bdbd9f605033122006cf227e5@mail.gmail.com>
Date: Fri, 1 Apr 2005 11:30:30 +0530
From: Manisha Jagadhane <manisha.vj@gmail.com>
To: Rune Torgersen <runet@innovsys.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859323@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <DCEAAC0833DD314AB0B58112AD99B93B859323@ismail.innsys.innovsys.com>
Subject: Re: custom board MPC8266
Reply-To: Manisha Jagadhane <manisha.vj@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the reply. 
I have seen the file arch/ppc/8260_io/commproc.c, but there is nowhere
given where to configure the SMC1/SMC2/SCC1/SCC2 as serial console. In
the .config file, whether we have to set CONFIG_SCC_CONSOLE=y option
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
> 
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

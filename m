Return-Path: <mukundjb@esntechnologies.co.in>
Received: from ns2.astrainfonets.net (unknown [202.125.86.130])
	by ozlabs.org (Postfix) with ESMTP id 309C22BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 17:04:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 10 Nov 2004 11:36:44 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348111ECD4C@mail.esn.co.in>
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Eugene Surovegin" <ebs@ebshome.net>,
	"Rick McBain" <rick.mcbain@logicsense.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Linux port for the 440EP processor
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Eugene,

I am need of 440EP Processor based Linux port.
I have some questions for what I am not sure of the answers I have.

Does 440EP processor come under 4xx type?
Is there a central repository for Linux distributions for 440 series?
Are there any tools, help Documents that can help build Linux
distribution for the 440EP Processor?
In "Linux for PowerPC Embedded Systems HOWTO" Document, the Target
Hardware's 4xx series points to some site addr & I didn't find any 440
processor support there?=20

Do I have access to the working 440GP & 440GX in both 2.4 & 2.6
developed by u? where can I find them?

Thanks for the support in advance.

Regards,
Mukund jampala

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org [mailto:linuxppc-embedded-
> bounces@ozlabs.org] On Behalf Of Eugene Surovegin
> Sent: Thursday, November 04, 2004 5:58 AM
> To: Rick McBain
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux port for the AMCC (was IBM) 440EP
>=20
> On Wed, Nov 03, 2004 at 03:17:27PM -0800, Rick McBain wrote:
> > Does anybody have a working distribution for the 440EP? We were
planning
> > to use a Timesys port, but we've now been told it doesn't exist
(after
> > months of promises it did.).  Our other option is to pay US$25K to
> > MontaVista, but that seems a tad pricey, and our previous experience
> > with them is that they delivered us an ARM port which fundamentally
> > didn't work.
> >
>=20
> Just FYI, 44x port was made by MontaVista.
>=20
> Try the following exercise, grep the kernel code and see how much was
> written for PPC by Timesys and then make your decision.
>=20
> FWIW, it should be relatively simple to do 440EP port, we already
> have working 440GP & 440GX in both 2.4 & 2.6.
>=20
> --
> Eugene.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

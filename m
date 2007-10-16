Return-Path: <Martin.Leisner@xerox.com>
Received: from wbmler2.mail.xerox.com (wbmler2.mail.xerox.com [13.13.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler2.mail.xerox.com",
	Issuer "wbmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 48AF6DDEBC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 02:37:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: cross compilation issue
Date: Tue, 16 Oct 2007 12:36:46 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C0750DDF0@USA0300MS03.na.xerox.net>
In-Reply-To: <OF1782007A.A1A7A36C-ON85257376.005181BD-85257376.00519317@rflelect.com>
References: <66E8AEE9980BB44CA5FCAD39EBA56AC6029A29DD@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
	<OF1782007A.A1A7A36C-ON85257376.005181BD-85257376.00519317@rflelect.com>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <ravi.rao@rflelect.com>, <avenkatesh@hcl.in>
Cc: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I sometimes found this painful...

I have a simple script in a configured directory "make-line" which looks =
like

bash2 :2 mleisner@linuxcom-01 11:53:58; cat make-line
#! /bin/bash

exec make ARCH=3Dpowerpc =
CROSS_COMPILE=3D/opt/denx/eldk4.1/usr/bin/ppc_74xx- =
INSTALL_MOD_PATH=3D${PWD}/root $*


I know hardhat linux had a strategy to make . files hiding the names of =
ARCH/CROSS_COMPILE -- so typing make
would work once configured...

IMHO it should be hardcoded in the Makefile after configuration -- it =
causes a lot of grief if you FORGET
to specify one of these and just type "make".

One of the things I want to do is look at how the linux make system =
works now (I recall at times I edit the Makefile
to hardcode these things).

marty
________________________________________
From: linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org] =
On Behalf Of ravi.rao@rflelect.com
Sent: Tuesday, October 16, 2007 10:52 AM
To: avenkatesh@hcl.in
Cc: linuxppc-embedded-bounces+ravi.rao=3Drflelect.com@ozlabs.org; =
linuxppc-embedded@ozlabs.org
Subject: Re: cross compilation issue


Hi,=20
=A0Easiest way is to edit the x86 Makefile so that gcc and ld points to =
Ur tool chain's ppc_6xx-gcc & ppc_6xx-ld..=20
Thanks,
Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com=20
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863=20
=A0=20

CONFIDENTIALITY NOTE

This e-mail, including any attachments, may contain confidential and/or =
legally privileged information.=A0 The Information is intended only for =
the use of the individual or entity named on this e-mail .=A0 If you are =
not the intended recipient, you are hereby notified that any disclosure, =
copying, distribution, or the taking of any action in reliance on the =
contents of this transmitted Information is strictly prohibited.=A0 =
Further, if you are not the intended recipient, please notify us by =
return e-mail and delete the Information promptly.=20
=A0=20
=A0=20
=A0=20

"Venkatesh Ananthakrishnan, TLS-Chennai" <avenkatesh@hcl.in>=20
Sent by: linuxppc-embedded-bounces+ravi.rao=3Drflelect.com@ozlabs.org=20
10/16/2007 10:24 AM=20
To
<linuxppc-embedded@ozlabs.org>=20
cc

Subject
cross compilation issue







Hai=20
I am newbi to linux.=20
I wrote the application usb libusb which works fine with x86 pc.=20
I want to compile the application for ppc. I have cross compiled libusb. =
I have tool chain also.=20
If I give ppc_6xx-gcc filename.c=20
It gives the error message as usb.h No such a file or directory.=20
How to give include path and library path during compilation?=20
Please do the needful=20
=A0=20
Regards,=20
Venkatesh=20
=A0=20
DISCLAIMER:
-------------------------------------------------------------------------=
----------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and =
intended for the named recipient(s) only.
It shall not attach any liability on the originator or HCL or its =
affiliates. Any views or opinions presented in=20
this email are solely those of the author and may not necessarily =
reflect the opinions of HCL or its affiliates.
Any form of reproduction, dissemination, copying, disclosure, =
modification, distribution and / or publication of=20
this message without the prior written consent of the author of this =
e-mail is strictly prohibited. If you have=20
received this email in error please delete it and notify the sender =
immediately. Before opening any mail and=20
attachments please check them for viruses and defect.

-------------------------------------------------------------------------=
----------------------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded=20

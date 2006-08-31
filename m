Return-Path: <cclo@astri.org>
Received: from asiwss02.astri.org (mail2.astri.org [203.198.202.21])
	by ozlabs.org (Postfix) with ESMTP id 7EA8067B22
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 10:49:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: RE: DS1302 driver for powerpc
Date: Thu, 31 Aug 2006 08:51:22 +0800
Message-ID: <A7B1E4DD46AA7046A4398F745240F29402737D5E@ASPROEXG.astri.local>
From: "Chun Chung Lo" <cclo@astri.org>
To: "Matt Porter" <mporter@embeddedalley.com>
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


Hi,

Thanks for your help.

But I also do not have this driver for 83xx. (as my linux is comes from
Montavista)

Could you mind providing me a link / or a source of such driver for me
to reference ?

Thanks.

Best regards,
Lo Chun Chung

-----Original Message-----
From: Matt Porter [mailto:mporter@embeddedalley.com]=0D
Sent: Wednesday, 30 August, 2006 9:55 PM
To: Chun Chung Lo
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: DS1302 driver for powerpc


On Wed, Aug 30, 2006 at 07:54:16PM +0800, Chun Chung Lo wrote:
>=0D
> Hi all,
>=0D
> I am now doing a STB project and the development board uses a DS1302=0D
> (trickle charge timekeeping chip) as a RTC. Our board is a IBM=0D
> PPC405EP with a linux kernel 2.4.20 running on it. And the DS1302 is=0D
> controlled by 2 GPIO pins instead of I2C.
>=0D
> I would like to ask are there any porting of DS1302 support under ppc=0D
> architecture? (I can only find DS1302 is supported under cris
> architecture.)

There doesn't seem to be any DS1302 support "for ppc" available.
However, even if there were a platform with DS1302 support you'd be in
the same boat as the low-level support for cris.  Support for DS1302 has
a glue layer that's board-specific based on what GPIO pins are used to
drive it.  So if you had this driver for another PPC system like 83xx
you'd still have no better starting point than the cris ds1302 driver
glue since the GPIO mechanism/connection is different. Porting the
board-specific glue from arch/cris/drivers/ds1302.c to 4xx GPIO is
trivial to do though.

-Matt

This message (including any attachments) is for the named addressee(s)'s=
 use only. It may contain
sensitive, confidential, private proprietary or legally privileged=
 information intended for a
specific individual and purpose, and is protected by law. If you are not=
 the intended recipient,
please immediately delete it and all copies of it from your system, destroy=
 any hard copies of it
and notify the sender. Any use, disclosure, copying, or distribution of=
 this message and/or any
attachments is strictly prohibited.

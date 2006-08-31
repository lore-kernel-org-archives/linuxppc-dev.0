Return-Path: <cclo@astri.org>
Received: from asiwss02.astri.org (mail2.astri.org [203.198.202.21])
	by ozlabs.org (Postfix) with ESMTP id 46CA067B76
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 11:01:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: RE: DS1302 driver for powerpc
Date: Thu, 31 Aug 2006 09:03:08 +0800
Message-ID: <A7B1E4DD46AA7046A4398F745240F29402737D61@ASPROEXG.astri.local>
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

That's good. I also started to work on it.=0D

Thanks for your quick reply.

Best regards,
Lo Chun Chung

-----Original Message-----
From: Matt Porter [mailto:mporter@embeddedalley.com]=0D
Sent: Thursday, 31 August, 2006 9:12 AM
To: Chun Chung Lo
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: DS1302 driver for powerpc


On Thu, Aug 31, 2006 at 08:51:22AM +0800, Chun Chung Lo wrote:
>=0D
> Hi,
>=0D
> Thanks for your help.
>=0D
> But I also do not have this driver for 83xx. (as my linux is comes=0D
> from
> Montavista)

The 83xx reference was a hypothetical. There is no 83xx driver for the
ds1302.
=0D
> Could you mind providing me a link / or a source of such driver for me

> to reference ?

My advice is to port the cris DS1302 driver to your board-specific GPIO
configuration.=0D

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

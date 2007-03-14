Return-Path: <MBenedict@twacs.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 87712DDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 11:03:27 +1100 (EST)
Received: from outbound4-fra.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-fra-R.bigfish.com (Postfix) with ESMTP id 4EA4A8D8BCA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 22:58:11 +0000 (UTC)
Received: from mail50-fra-R.bigfish.com (unknown [10.4.252.3])
	by outbound4-fra.bigfish.com (Postfix) with ESMTP id 3452D850065
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 22:58:11 +0000 (UTC)
Received: from mail50-fra (localhost.localdomain [127.0.0.1])
	by mail50-fra-R.bigfish.com (Postfix) with ESMTP id 27FEC82017B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 22:58:11 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail50-fra.bigfish.com (Postfix) with ESMTP id B9BF2BF805F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 22:58:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FW: U-boot with flat device tree
Date: Wed, 14 Mar 2007 17:57:54 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC279540@twx-exch01.twacs.local>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 Sorry, I intended to reply to the list but accidently hit "reply"

-----Original Message-----
From: Benedict, Michael=20
Sent: Wednesday, March 14, 2007 5:51 PM
To: 'Kim Phillips'
Subject: RE: U-boot with flat device tree

Yep, thanks

If I repeat the above, but call bootm with only the kernel address, I
get a full boot sequence on the console up to the point that the kernel
bails because it is unable to mount the root filesystem.
	Thank you,
		Michael

-----Original Message-----
From: Kim Phillips [mailto:kim.phillips@freescale.com]
Sent: Wednesday, March 14, 2007 5:47 PM
To: Benedict, Michael
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: U-boot with flat device tree

On Wed, 14 Mar 2007 16:42:49 -0500
"Benedict, Michael" <MBenedict@twacs.com> wrote:


>    Uncompressing Kernel Image ... OK
>    Booting using flat device tree at 0x1000000
>=20
>=20
>=20
> <stuck>

are you setting console=3DttyS0,115200?

Kim

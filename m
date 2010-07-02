Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B0101007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 16:04:06 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o62643LI011227
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jul 2010 23:04:03 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o626ELFP007975
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jul 2010 01:14:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: CONFIG_NO_HZ causing poor console responsiveness
Date: Fri, 2 Jul 2010 14:03:53 +0800
Message-ID: <F9BD3E0A8083BE4ABAA94D7EDD7E3F6304C702@zch01exm26.fsl.freescale.net>
In-Reply-To: <1278049644.4200.377.camel@pasglop>
References: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
	<1278049644.4200.377.camel@pasglop>
From: "Li Yang-R58472" <r58472@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Tabi Timur-B04825" <B04825@freescale.com>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>-----Original Message-----
>From: linuxppc-dev-bounces+leoli=3Dfreescale.com@lists.ozlabs.org
>[mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@lists.ozlabs.org] On
>Behalf Of Benjamin Herrenschmidt
>Sent: Friday, July 02, 2010 1:47 PM
>To: Tabi Timur-B04825
>Cc: Linuxppc-dev Development
>Subject: Re: CONFIG_NO_HZ causing poor console responsiveness
>
>On Tue, 2010-06-29 at 14:54 -0500, Timur Tabi wrote:
>> I'm adding support for a new e500-based board (the P1022DS), and in
>> the process I've discovered that enabling CONFIG_NO_HZ (Tickless
>> System / Dynamic Ticks) causes significant responsiveness problems on
>> the serial console.  When I type on the console, I see delays of up =
to
>> a half-second for almost every character.  It acts as if there's a
>> background process eating all the CPU.
>>
>> I don't have time to debug this thoroughly at the moment.  The =
problem
>> occurs in the latest kernel, but it appears not to occur in 2.6.32.
>>
>> Has anyone else seen anything like this?
>
>I noticed that on the bimini with 2.6.35-rc* though I didn't get to =
track
>it down yet.


Patch found at the following location fixed this problem.

http://www.spinics.net/lists/linux-tip-commits/msg08279.html

Hope it has already been merged.

- Leo

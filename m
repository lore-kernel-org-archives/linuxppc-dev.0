Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F2E52C029D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:42:33 +1000 (EST)
Received: from mail132-co1 (localhost [127.0.0.1])	by
 mail132-co1-R.bigfish.com (Postfix) with ESMTP id CF07A1200AF	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:42:29 +0000 (UTC)
Received: from CO1EHSMHS025.bigfish.com (unknown [10.243.78.229])	by
 mail132-co1.bigfish.com (Postfix) with ESMTP id 3B18BAC0074	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:42:28 +0000 (UTC)
Date: Mon, 17 Jun 2013 19:42:06 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/5] powerpc/dts: update MSI bindings doc for MPIC v4.3
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <1371515287.9073.15@snotra> (from scottwood@freescale.com on
 Mon Jun 17 19:28:07 2013)
Message-ID: <1371516126.9073.16@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>,
 Lian Minghuan-b31939 <B31939@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2013 07:28:07 PM, Scott Wood wrote:
> On 06/17/2013 12:07:41 AM, Lian Minghuan-b31939 wrote:
>>>> +    compatible =3D "fsl,mpic-msi";
>>>> +    reg =3D <0x41600 0x200 0x44140 4>;
>>>=20
>>> Why 0x200?
>>>=20
>> [Minghuan] The offsets of the MSIA registers are from 0x41600 to =20
>> 0x417ff, and the size is 0x200.
>> offset 0x41600-0x4170 are MSIIRA1-7.
>> 0x41720 is MSISRA,
>> 0x41750 is MSIIR.
>> The others are reserved.
>=20
> There is no MSIIRA on fsl,mpic-msi.

Sigh, I was thinking of MSIIR1A -- which of course is distinct from =20
both MSIIRA1 and MSIIRA. :-P

So it's just a bug that pq3-mpic.dtsi has a length of 0x80?

-Scott=

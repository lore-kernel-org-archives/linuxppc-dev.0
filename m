Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 8D9CDB6F11
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 21:57:16 +1000 (EST)
Received: by iwn37 with SMTP id 37so6984876iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 04:57:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A1FC299@zch01exm23.fsl.freescale.net>
References: <AANLkTik3ViwjmOFfm6GUwmuzMkO75+2pCUdnC0z8A7Jb@mail.gmail.com>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC150@zch01exm23.fsl.freescale.net>
	<20100913112749.2fb32b3d@schlenkerla.am.freescale.net>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC299@zch01exm23.fsl.freescale.net>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 14 Sep 2010 06:56:44 -0500
Message-ID: <AANLkTim2HAnwF7wdbJb_Oc9rzPVe0Y-B7nOHiUVoWef=@mail.gmail.com>
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue with
	36bit mode
To: Zang Roy-R61911 <r61911@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 13, 2010 at 11:09 PM, Zang Roy-R61911 <r61911@freescale.com> wr=
ote:

>> > > Shouldn't this be u32 or __be32, for consistency with the actual
>> > > comparisons below?
>> > __be32 is better.
>>
>> I disagree, the return from this function is native-endian. =A0It should
>> be u32.
> But the return of this value is ONLY used for br comparing. It is big end=
ia.
> Thanks.

No, Scott is right.  The return value is native-endian (NE).  You've
converted it from BE to NE already.

--=20
Timur Tabi
Linux kernel developer at Freescale

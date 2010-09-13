Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 0FE6F1007D2
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 00:35:45 +1000 (EST)
Received: by iwn37 with SMTP id 37so6010755iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 07:35:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1284388075.10955.51.camel@localhost>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
	<20100909114153.GB6622@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC158@zch01exm23.fsl.freescale.net>
	<AANLkTimfKwdw+nLAjDjxf52dbZKLF-3aES+bT7CHskAS@mail.gmail.com>
	<1284388075.10955.51.camel@localhost>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Mon, 13 Sep 2010 09:35:14 -0500
Message-ID: <AANLkTinyELs7KNDQxWsaR8Ea13SewWYwgtnie_P7cAzC@mail.gmail.com>
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue with
	36bit mode
To: dedekind1@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 13, 2010 at 9:27 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:

> Yes, sizeof(int) == 4 assumption is not good.
>
> But sizeof(int) >= 4 is perfectly fine.

I have to disagree.   I don't see how you can say that == is not okay,
but >= is okay.  That just doesn't make any sense.  Obviously, you
have to make some assumptions about sizeof(int), but that assumption
should be nothing more than "it should be big enough for these small
numbers that I'm using".

> I see people use u32 and the friends too much.

I agree with that.

-- 
Timur Tabi
Linux kernel developer at Freescale

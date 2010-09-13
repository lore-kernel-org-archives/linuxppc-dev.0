Return-Path: <dedekind1@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 28968B6F14
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 04:46:35 +1000 (EST)
Received: by bwz7 with SMTP id 7so7222947bwz.15
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 11:46:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue
	with 36bit mode
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Timur Tabi <timur.tabi@gmail.com>
In-Reply-To: <AANLkTimUR5-hWRkDAwWTXJYCOcse7LTR0r-vSsZec1g1@mail.gmail.com>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
	<20100909114153.GB6622@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC158@zch01exm23.fsl.freescale.net>
	<AANLkTimfKwdw+nLAjDjxf52dbZKLF-3aES+bT7CHskAS@mail.gmail.com>
	<1284388075.10955.51.camel@localhost>
	<AANLkTinyELs7KNDQxWsaR8Ea13SewWYwgtnie_P7cAzC@mail.gmail.com>
	<1284396320.1783.30.camel@brekeke>
	<AANLkTimUR5-hWRkDAwWTXJYCOcse7LTR0r-vSsZec1g1@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Sep 2010 21:46:26 +0300
Message-ID: <1284403586.1783.42.camel@brekeke>
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-09-13 at 13:36 -0500, Timur Tabi wrote:
> On Mon, Sep 13, 2010 at 11:45 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > Unsigned int is reliably >= 4 in Linux.
> 
> Not exactly.  sizeof(unsigned int) is effectively never greater than 4
> in Linux

I know and said the same in the other paragraph which you cut.

>  (I think it's still 32 bits even on a 64-bit kernel)

Yes.

> , so it
> makes no sense to say >=.  So since you can't say that sizeof(int) ==
> 4, and you can't say that sizeof(int) > 4, then you certainly can't
> say that sizeof(int) >= 4.

It also makes no sense to send "makes no sense" answer 2 times in a row
and it makes no sense to not read and not try to understand the e-mail
you are replying (even though the english of the writer is not perfect)
So it makes no sense to continue arguing.

But it makes some sense to go sleep, good night.

-- 
Best Regards,
Artem Bityutskiy (Битюцкий Артём)

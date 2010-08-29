Return-Path: <dedekind1@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id BAD93B7116
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Aug 2010 21:06:54 +1000 (EST)
Received: by gyd10 with SMTP id 10so2698136gyd.15
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Aug 2010 04:06:53 -0700 (PDT)
Subject: RE: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc interrupt
	common to elbc devices
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Zang Roy-R61911 <r61911@freescale.com>
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A03E044@zch01exm23.fsl.freescale.net>
References: <3850A844E6A3854C827AC5C0BEC7B60A03E044@zch01exm23.fsl.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 29 Aug 2010 14:06:46 +0300
Message-ID: <1283080006.2131.2.camel@brekeke>
Mime-Version: 1.0
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, linux-mtd@lists.infradead.org,
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

On Mon, 2010-08-09 at 15:33 +0800, Zang Roy-R61911 wrote:
> Any comment about this serial patches?
> If none, I'd ask Andrew to merge to his mm tree.

Could you please separate out MTD stuff, to the extent it is possible to
do?
-- 
Best Regards,
Artem Bityutskiy (Битюцкий Артём)

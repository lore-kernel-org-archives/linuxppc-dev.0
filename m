Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A2B012C0083
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2012 22:14:06 +1000 (EST)
Received: from mail95-co1 (localhost [127.0.0.1])	by mail95-co1-R.bigfish.com
 (Postfix) with ESMTP id B3C7440018C	for <linuxppc-dev@ozlabs.org>;
 Wed,  8 Aug 2012 12:14:02 +0000 (UTC)
Received: from CO1EHSMHS027.bigfish.com (unknown [10.243.78.250])	by
 mail95-co1.bigfish.com (Postfix) with ESMTP id EEA18C8004A	for
 <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2012 12:14:00 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Yin Olivia-R63875 <r63875@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/e500v2: Add power isa properties to comply
 with ePAPR 1.1
Date: Wed, 8 Aug 2012 12:13:59 +0000
Message-ID: <CAOZdJXV0w78rqiGy=5SfpC3CA+9EwtgZ6goSciYhO2+YARfmgQ@mail.gmail.com>
References: <1344408808-29411-1-git-send-email-hong-hua.yin@freescale.com>
In-Reply-To: <1344408808-29411-1-git-send-email-hong-hua.yin@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 8, 2012 at 1:53 AM, Olivia Yin <hong-hua.yin@freescale.com> wro=
te:
> The patch update all e500v2 platforms.

Could you provide some more information about the ePAPR requirement?

> + * e500v2 power isa Device Tree Source (include)

Power ISA

> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions ar=
e met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyrig=
ht
> + *       notice, this list of conditions and the following disclaimer in=
 the
> + *       documentation and/or other materials provided with the distribu=
tion.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote pro=
ducts
> + *       derived from this software without specific prior written permi=
ssion.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of th=
e
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND AN=
Y

Please use normal quotation marks

   "AS IS"

--=20
Timur Tabi
Linux kernel developer at Freescale=

Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 20EA21007D6
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 12:05:59 +1100 (EST)
Received: from mail160-va3 (localhost [127.0.0.1])	by
 mail160-va3-R.bigfish.com (Postfix) with ESMTP id BD21F66011A	for
 <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 01:05:55 +0000 (UTC)
Received: from VA3EHSMHS005.bigfish.com (unknown [10.7.14.253])	by
 mail160-va3.bigfish.com (Postfix) with ESMTP id 5CA93700049	for
 <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 01:05:55 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: create 32-bit DTS for the P1022DS
Date: Thu, 8 Dec 2011 01:05:51 +0000
Message-ID: <4EE00D6D.70805@freescale.com>
References: <1323302665-26461-1-git-send-email-timur@freescale.com>
 <1323302665-26461-2-git-send-email-timur@freescale.com>
 <4EDFFFEA.5030603@freescale.com>
In-Reply-To: <4EDFFFEA.5030603@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> +			interrupts =3D<8 8 0 0>;
>> >  +		};
> It's not new to this patch, but... what does "8" mean in the second cell
> of an mpic interrupt specifier?

I have no idea.

> And why does the indirect pixis node
> not have the interrupt?

Hmmm... I suppose I could add it, but I don't know what good it would do.=20
  The code that's looking for the interrupt is probing on "fsl,p1022ds-fpga=
".

--=20
Timur Tabi
Linux kernel developer at Freescale=

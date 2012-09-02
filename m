Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4EB662C0092
 for <linuxppc-dev@ozlabs.org>; Sun,  2 Sep 2012 12:50:52 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Ben Dubb <ben.dubb@gmail.com>
Subject: Re: [PATCH] QE USB host fix for mpc832x
Date: Sun, 2 Sep 2012 02:50:47 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708019EA6@039-SN2MPN1-022.039d.mgd.msft.net>
References: <CACLP1513KDxU95cY0_tpMqenwFmc8WZyuQMbaZbvU_pZdVqkSg@mail.gmail.com>
In-Reply-To: <CACLP1513KDxU95cY0_tpMqenwFmc8WZyuQMbaZbvU_pZdVqkSg@mail.gmail.com>
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

On Wed, Aug 22, 2012 at 10:54 PM, Ben Dubb <ben.dubb@gmail.com> wrote:
> This patch should be used to get QE USB host mode working on mpc832x and
> mpc8360
> based devices. It fixes the following issues:
>
> - BRG divisor shall not be an add number greater than 3.
> - USB param block in multi-user ram can't be accessed at default location=
 on
> mpc832x
>   device. Allocate it dynamically.

I think this should be two separate patches.

--=20
Timur Tabi
Linux kernel developer at Freescale=

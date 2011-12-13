Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5DF1A1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2011 07:56:58 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Michael Neuling <mikey@neuling.org>, Gala Kumar-B11780
 <B11780@freescale.com>
Subject: Re: [PATCH] powerpc: fix compile error with 85xx/p1022_ds.c
Date: Tue, 13 Dec 2011 20:56:48 +0000
Message-ID: <CAOZdJXVyQd2CYCArTU1+6hRxOeVPkJP1evrGRKeO7cQPBU_vFA@mail.gmail.com>
References: <22284.1323643754@neuling.org>
In-Reply-To: <22284.1323643754@neuling.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 11, 2011 at 4:49 PM, Michael Neuling <mikey@neuling.org> wrote:
> Current linux-next compiled with mpc85xx_defconfig causes this:
> =A0arch/powerpc/platforms/85xx/p1022_ds.c:341:14: error: 'udbg_progress' =
undeclared here (not in a function)
>
> Add include to fix this.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Timur Tabi <timur@freescale.com>

--=20
Timur Tabi
Linux kernel developer at Freescale=

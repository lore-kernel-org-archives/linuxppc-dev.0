Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B581B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 03:13:16 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] powerpc/watchdog: move booke watchdog param related
 code to prom.c
Date: Tue, 8 May 2012 17:13:05 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03CF692C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1336457231-32513-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1336457231-32513-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.=
org] On
> Behalf Of Shaohui Xie
> Sent: Tuesday, May 08, 2012 11:37 AM
> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: Xie Shaohui-B21989
> Subject: [PATCH 1/2] powerpc/watchdog: move booke watchdog param related =
code to
> prom.c
>=20
> Currently, BOOKE watchdog code for checking "wdt" and "wdt_period" is in
> setup_32.c, it cannot be used in 64-bit, so move it to a common place pro=
m.c,
> which will be shared by 32-bit and 64-bit.
>=20
> Also, replace the simple_strtoul with kstrtol.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
>  arch/powerpc/kernel/prom.c     |   27 +++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup_32.c |   24 ------------------------
>  2 files changed, 27 insertions(+), 24 deletions(-)

Is not setup-common.c is better place to move this?

Thanks
-Bharat

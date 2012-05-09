Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58880B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 13:27:15 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] powerpc/watchdog: move booke watchdog param related
 code to prom.c
Date: Wed, 9 May 2012 03:27:06 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03CF86B7@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1336457231-32513-1-git-send-email-Shaohui.Xie@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D03CF692C@039-SN2MPN1-023.039d.mgd.msft.net>
 <ED492CCEAF882048BC2237DE806547C90B2EB2@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <ED492CCEAF882048BC2237DE806547C90B2EB2@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Xie Shaohui-B21989
> Sent: Wednesday, May 09, 2012 8:50 AM
> To: Bhushan Bharat-R65777; linux-watchdog@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: RE: [PATCH 1/2] powerpc/watchdog: move booke watchdog param rela=
ted
> code to prom.c
>=20
> >> -----Original Message-----
> >> From:
> >> linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org
> >> [mailto:linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozla=
b
> >> s
> >> .org] On Behalf Of Shaohui Xie
> >> Sent: Tuesday, May 08, 2012 11:37 AM
> >> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> >> Cc: Xie Shaohui-B21989
> >> Subject: [PATCH 1/2] powerpc/watchdog: move booke watchdog param
> >> related code to prom.c
> >>
> >> Currently, BOOKE watchdog code for checking "wdt" and "wdt_period" is
> >> in setup_32.c, it cannot be used in 64-bit, so move it to a common
> >> place prom.c, which will be shared by 32-bit and 64-bit.
> >>
> >> Also, replace the simple_strtoul with kstrtol.
> >>
> >> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> >> ---
> >>  arch/powerpc/kernel/prom.c     |   27 +++++++++++++++++++++++++++
> >>  arch/powerpc/kernel/setup_32.c |   24 ------------------------
> >>  2 files changed, 27 insertions(+), 24 deletions(-)
> >
> >Is not setup-common.c is better place to move this?
>=20
> Move out from setup_32.c does not mean it have to go into setup-common.c,=
 I need
> better reason to do this.
>=20

What I think that setup_32.c is for 32 bit, setup_64.c is for 64 bit and se=
tup-common.c is for both.

I am not saying that you move this to setup-common.c. I am asking why you h=
ave not used setup-common.c ? I am ok even with prom.c.


Thanks
-Bharat

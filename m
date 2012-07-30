Return-Path: <B37400@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A04142C0089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 19:51:05 +1000 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: RE: [2/3][PATCH][v2] TDM Framework
Date: Mon, 30 Jul 2012 09:50:57 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
In-Reply-To: <20120727152542.GB1613@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for your comments. Please find replies inline.

Regards,
Sandeep

-----Original Message-----
From: Francois Romieu [mailto:romieu@fr.zoreil.com]=20
Sent: 27 July 2012 20:56
To: Singh Sandeep-B37400
Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org; ga=
lak@kernel.crashing.org; linux-kernel@vger.kernel.org; devel@driverdev.osuo=
sl.org
Subject: Re: [2/3][PATCH][v2] TDM Framework

sandeep@freescale.com <sandeep@freescale.com> :
[...]
> The main functions of this Framework are:
>  - provides interface to TDM clients to access TDM functionalities.
>  - provides standard interface for TDM drivers to hook with the framework=
.
>  - handles various data handling stuff and buffer management.
>=20
> In future this Framework will be extended to provide Interface for Line c=
ontrol devices also. For example SLIC, E1/T1 Framers etc.
>=20
> Presently the framework supports only Single Port channelised mode.
> Also the configurability options are limited which will be extended later=
 on.
> Only kernel mode TDM clients are supported currently. Support for User mo=
de clients will be added later.

1. You should send some kernel mode TDM clients. Without those the framewor=
k
   is pretty useless.
[Sandeep] We do have a test client but not good enough to be pushed in open=
 source, should we add it to documentation??=20

2. It would probably make sense to Cc: netdev and serial. There may be
   some kernel client network integration from the start.
[Sandeep] Ok.=20

3. Where is the userspace configuration interface ?
[Sandeep] TDM framework right now supports only kernel mode clients. It has=
 been tested with the client module that I mentioned above. Both the framew=
ork and test client are a part of Freescale BSP.

[...]
> Based on: git://git.am.freescale.net/gitolite/mirrors/galak-powerpc.git
[Sandeep] Please try below mentioned link. The above one is Freescale's int=
ernal mirror of:
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git=20

$ git clone git://git.am.freescale.net/gitolite/mirrors/galak-powerpc.git
Cloning into 'galak-powerpc'...
fatal: Unable to look up git.am.freescale.net (port 9418) (No address assoc=
iated with hostname)

--=20
Ueimor

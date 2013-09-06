Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 198352C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:17:31 +1000 (EST)
Message-ID: <1378480637.12204.179.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: Add I2C bus multiplexer node for B4 and T4240QDS
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Fri, 6 Sep 2013 10:17:17 -0500
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B1506A44E@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378194704-29909-1-git-send-email-hongtao.jia@freescale.com>
 <52268C7E.4040209@windriver.com>
 <D07C73A334FF604B95B3CBD2A545D07B15056D07@039-SN2MPN1-011.039d.mgd.msft.net>
 <1378406443.12204.102.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B1506A44E@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Yang,
 Wei" <Wei.Yang@windriver.com>, Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-05 at 21:30 -0500, Tang Yuantian-B29983 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: 2013=E5=B9=B49=E6=9C=886=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=BA=94 2=
:41
> > To: Tang Yuantian-B29983
> > Cc: Yang,Wei; Jia Hongtao-B38951; Wood Scott-B07421; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc: Add I2C bus multiplexer node for B4 and
> > T4240QDS
> >=20
> > On Tue, 2013-09-03 at 22:30 -0500, Tang Yuantian-B29983 wrote:
> > > Hi,
> > >
> > > These eeproms are never used by kernel. So no need to add them.
> >=20
> > The device tree describes the hardware, not what Linux does with it.
> >=20
> Missing some nodes doesn't mean it is not describing the hardware.
> There are almost fifty I2C devices on T4 connected to PCA9547.
> Do you think we need to list them all?

Ideally, yes.  I realize it's not uncommon for some things to be
missing, but that's not a reason to tell people to leave things out just
because Linux doesn't use them.

-Scott

Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B95D2C016A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 12:34:19 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V3] powerpc/85xx: Add support for 85xx cpu type detection
Date: Wed, 17 Jul 2013 02:34:09 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13C4302@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1373502232-4772-1-git-send-email-Haijun.Zhang@freescale.com>
 <99E897753B6F7048BD8CCDB4661D02E13C0099@039-SN2MPN1-023.039d.mgd.msft.net>
 <1373994129.8183.330@snotra> <1374018865.8183.349@snotra>
In-Reply-To: <1374018865.8183.349@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Wrobel Heinz-R39252 <r39252@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Of course.
I'll send patch v4 to add the rest of them.

Thanks.

Regards
Haijun.


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, July 17, 2013 7:54 AM
> To: Wood Scott-B07421
> Cc: Zhang Haijun-B42677; linux-mmc@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; cbouatmailru@gmail.com; cjb@laptop.org; Wood Scott-
> B07421; Fleming Andy-AFLEMING; Wrobel Heinz-R39252; Zhao Chenhui-B35336
> Subject: Re: [PATCH V3] powerpc/85xx: Add support for 85xx cpu type
> detection
>=20
> On 07/16/2013 12:02:09 PM, Scott Wood wrote:
> > On 07/16/2013 03:46:44 AM, Zhang Haijun-B42677 wrote:
> >> Hi, scott
> >>
> >> Need I change something?
> >> I have some patches depend on this.
> >> Expect your advice.
> >>
> >> Thanks.
> >>
> >> Regards
> >> Haijun.
> >
> > It looks OK; go ahead and send the patches that depend on it.
>=20
> Actually, could you add p2040, p4040, p4080, p5021, and any other missing
> ones you notice (lots of e500v2 P1/P2 chips are missing too)?
>=20
> At the very least p2040 and p5021 ought to be there if you're using this
> to check for p2041/p5040 errata, since they're basically the same chip
> and thus have the same errata.
>=20
> -Scott

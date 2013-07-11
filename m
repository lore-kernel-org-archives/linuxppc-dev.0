Return-Path: <B42677@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 896882C02ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 19:00:06 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
 detection
Date: Thu, 11 Jul 2013 09:02:10 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E139F499@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Wed Jul 10 02:39:01 2013)
 <1373492893.8183.236@snotra>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Xie Xiaobo-R63061 <r63061@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
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



Thanks.

Regards
Haijun.


> -----Original Message-----
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Thursday, July 11, 2013 4:44 PM
> To: Wood Scott-B07421; Zhang Haijun-B42677
> Cc: Zhao Chenhui-B35336; linux-mmc@vger.kernel.org; Wrobel Heinz-R39252;
> Fleming Andy-AFLEMING; Zhang Haijun-B42677; cbouatmailru@gmail.com;
> cjb@laptop.org; linuxppc-dev@lists.ozlabs.org; Xie Xiaobo-R63061
> Subject: RE: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
> detection
>=20
> > > +#define IS_SVR_REV(svr, maj, min) \
> > > +	((SVR_MAJ(svr) =3D=3D (maj)) && (SVR_MIN(svr) =3D=3D (min)))
> >
> > I don't think IS_SVR_REV is needed.  Callers can just do "if
> > (SVR_REV(svr) =3D=3D 0x30)" or whatever, especially since we're relying=
 on
> > them to do this for greater/less than comparisons.
>=20
> Not only that, I'd guess that 'maj' and 'min' are likely to be constants
> - so you'd want to combine them and compare against 'svr'
> rather than have two conditionals.
[Haijun Wrote:] yes, e.g: 1.0, 1.1 or 2.0. 'Major revision field' + '.' + '=
Minor revision field '
I had resent the patch(V2). I'm not so clear about what you want to express=
.^_^ =20
>=20
> 	David
>=20
>=20
>=20

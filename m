Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 696932C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 01:24:24 +1000 (EST)
Date: Thu, 18 Jul 2013 10:24:12 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-R1.0
To: Zang Roy-R61911 <r61911@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
 <1374081074.8183.360@snotra>
 <3E027F8168735B46AC006B1D0C7BB0020B27D1E9@039-SN2MPN1-012.039d.mgd.msft.net>
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB0020B27D1E9@039-SN2MPN1-012.039d.mgd.msft.net>
 (from r61911@freescale.com on Wed Jul 17 21:30:45 2013)
Message-ID: <1374161052.5357.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Zhang Haijun-B42677 <B42677@freescale.com>,
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

On 07/17/2013 09:30:45 PM, Zang Roy-R61911 wrote:
>=20
>=20
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Scott Wood
> >
> > On 07/17/2013 05:11:30 AM, Haijun Zhang wrote:
> > > Vender version and sdhc spec version of T4240-R1.0 is incorrect.
> > > The right value should be VVN=3D0x13, SVN =3D 0x1. The wrong version
> > > number will break down the ADMA data transfer.
> > > This defect only exist in T4240-R1.0. Will be fixed in T4240-R2.0.
> > > Also share vvn and svr for public use.
> > >
> > > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> >
> > We're not supporting T4240 rev 1.0 in upstream Linux, as it's not
> > production silicon.
> As discussed, production silicon Rev 2.0 will also suffer this issue. =20
> So need to address it beyond T4240-R2.0.

OK -- please update the commit message.

-Scott=

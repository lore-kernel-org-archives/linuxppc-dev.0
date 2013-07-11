Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 770C62C0312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 00:15:34 +1000 (EST)
Date: Thu, 11 Jul 2013 09:15:17 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
 detection
To: David Laight <David.Laight@ACULAB.COM>
References: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com>
 <1373492893.8183.236@snotra>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
 (from David.Laight@ACULAB.COM on Thu Jul 11 03:43:35 2013)
Message-ID: <1373552117.8183.243@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>, linux-mmc@vger.kernel.org,
 r39252@freescale.com, AFLEMING@freescale.com, X.Xie@freescale.com,
 cbouatmailru@gmail.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 03:43:35 AM, David Laight wrote:
> > > +#define IS_SVR_REV(svr, maj, min) \
> > > +	((SVR_MAJ(svr) =3D=3D (maj)) && (SVR_MIN(svr) =3D=3D (min)))
> >
> > I don't think IS_SVR_REV is needed.  Callers can just do "if
> > (SVR_REV(svr) =3D=3D 0x30)" or whatever, especially since we're relying=
 =20
> on
> > them to do this for greater/less than comparisons.
>=20
> Not only that, I'd guess that 'maj' and 'min' are likely to be
> constants - so you'd want to combine them and compare against 'svr'
> rather than have two conditionals.

Yes, that's what I meant -- 0x30 would represent revision 3.0.

-Scott=

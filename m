Return-Path: <B36685@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2BC12B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 13:59:14 +1100 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Phillips Kim-R1AAHA <R1AAHA@freescale.com>
Subject: RE: [PATCH v2] powerpc/dts: fix the compatible string of sec 4.0
Date: Thu, 8 Mar 2012 02:59:00 +0000
Message-ID: <3F453DDFF675A64A89321A1F35281021710920@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1331097606-22407-1-git-send-email-Shengzhou.Liu@freescale.com>
 <20120307172611.86985d2c22af2c3213770f35@freescale.com>
In-Reply-To: <20120307172611.86985d2c22af2c3213770f35@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Liu Shuo-B35362 <B35362@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "stable@kernel.org" <stable@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Phillips Kim-R1AAHA
> Sent: Thursday, March 08, 2012 7:26 AM
> To: Liu Shengzhou-B36685
> Cc: linuxppc-dev@lists.ozlabs.org; stable@kernel.org; Liu Shuo-B35362
> Subject: Re: [PATCH v2] powerpc/dts: fix the compatible string of sec
> 4.0
>=20
> On Wed, 7 Mar 2012 13:20:06 +0800
> Shengzhou Liu <Shengzhou.Liu@freescale.com> wrote:
>=20
> > From: Liu Shuo <shuo.liu@freescale.com>
> >
> > Fix the compatible string of sec 4.0 to match with CAMM driver
> > according to Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> >
> > Signed-off-by: Liu Shuo <shuo.liu@freescale.com>
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > ---
> > v2: refine description.
>=20
> can we patch the caam driver to still work with "fsl-sec4.0"?
>=20
> Thanks,
>=20
> Kim
[Shengzhou] ok, I will post another patch for it. Thanks.

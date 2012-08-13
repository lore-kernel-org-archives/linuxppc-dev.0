Return-Path: <B36685@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B2512C007D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2012 13:01:24 +1000 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when missing USB
 PHY clock
Date: Mon, 13 Aug 2012 03:01:14 +0000
Message-ID: <3F453DDFF675A64A89321A1F3528102178AD97@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1344595712-12804-2-git-send-email-Shengzhou.Liu@freescale.com>
 <366E392A-9EAE-43C9-8666-808EA19C03EA@kernel.crashing.org>
In-Reply-To: <366E392A-9EAE-43C9-8666-808EA19C03EA@kernel.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, August 10, 2012 9:50 PM
> To: Liu Shengzhou-B36685
> Cc: linuxppc-dev@lists.ozlabs.org list; linux-usb@vger.kernel.org;
> gregkh@linuxfoundation.org
> Subject: Re: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when missing US=
B PHY
> clock
>=20
>=20
> On Aug 10, 2012, at 5:48 AM, Shengzhou Liu wrote:
>=20
> > when missing USB PHY clock, kernel booting up will hang during USB
> > initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid CPU
> > hanging in this case.
> >
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > ---
> > drivers/usb/host/ehci-fsl.c |   63 ++++++++++++++++++++++++++++++------=
-----
> -
> > drivers/usb/host/ehci-fsl.h |    1 +
> > 2 files changed, 46 insertions(+), 18 deletions(-)
>=20
> I assume this should be considered a bug fix and be looked at for inclusi=
on in
> v3.6?
>=20
> - k
[Shengzhou] Yes.=20

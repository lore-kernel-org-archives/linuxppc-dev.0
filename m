Return-Path: <B36685@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 562FB2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 19:31:42 +1000 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Greg KH <greg@kroah.com>
Subject: RE: [PATCH v2] powerpc/usb: fix bug of CPU hang when missing USB
 PHY clock
Date: Tue, 18 Sep 2012 09:31:33 +0000
Message-ID: <3F453DDFF675A64A89321A1F352810217FE2A8@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1345630620-32070-1-git-send-email-Shengzhou.Liu@freescale.com>
 <6E81CB63-79F1-4C45-87A6-28048351FF84@kernel.crashing.org>
In-Reply-To: <6E81CB63-79F1-4C45-87A6-28048351FF84@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
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
> Sent: Tuesday, September 18, 2012 1:35 PM
> To: Greg KH
> Cc: Liu Shengzhou-B36685; linuxppc-dev@lists.ozlabs.org list; linux-
> usb@vger.kernel.org
> Subject: Re: [PATCH v2] powerpc/usb: fix bug of CPU hang when missing USB
> PHY clock
>=20
>=20
> On Aug 22, 2012, at 5:17 AM, Shengzhou Liu wrote:
>=20
> > when missing USB PHY clock, kernel booting up will hang during USB
> > initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid CPU
> > hanging in this case.
> >
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > ---
> > v2 changes: use spin_event_timeout() instead.
> >
> > drivers/usb/host/ehci-fsl.c |   58 +++++++++++++++++++++++++++++-------
> ------
> > drivers/usb/host/ehci-fsl.h |    1 +
> > include/linux/fsl_devices.h |    1 +
> > 3 files changed, 42 insertions(+), 18 deletions(-)
>=20
> Greg,
>=20
> Any issues picking this fix up for v3.6 inclusion?
>=20
> - k
>=20

[Shengzhou] please pick the v3, thanks.
http://patchwork.ozlabs.org/patch/184666/

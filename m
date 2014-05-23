Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4EF91A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 18:03:52 +1000 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
Date: Fri, 23 May 2014 08:03:44 +0000
Message-ID: <474028133ffd49cebfeb951498923caa@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1400666751-11459-2-git-send-email-Shengzhou.Liu@freescale.com>
 <20140522225144.GA1670@home.buserror.net>
In-Reply-To: <20140522225144.GA1670@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, May 23, 2014 6:52 AM
> To: Liu Shengzhou-B36685
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
>=20
> > +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> > @@ -125,6 +125,11 @@ CONFIG_USB_EHCI_FSL=3Dy  CONFIG_USB_STORAGE=3Dy
> > CONFIG_MMC=3Dy  CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_RTC_CLASS=3Dy
> > +CONFIG_RTC_DRV_CMOS=3Dy
> > +CONFIG_RTC_DRV_DS1307=3Dy
> > +CONFIG_RTC_DRV_DS1374=3Dy
> > +CONFIG_RTC_DRV_DS3232=3Dy
> >  CONFIG_EDAC=3Dy
> >  CONFIG_EDAC_MM_EDAC=3Dy
> >  CONFIG_DMADEVICES=3Dy
>=20
> Why only corenet64 and not corenet32?
>=20
> -Scott
[Shengzhou] There is already RTC support in corenet32, only missing in core=
net64.

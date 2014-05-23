Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74E721A007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 03:06:22 +1000 (EST)
Message-ID: <1400864771.12823.51.camel@snotra.buserror.net>
Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
Date: Fri, 23 May 2014 12:06:11 -0500
In-Reply-To: <474028133ffd49cebfeb951498923caa@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1400666751-11459-2-git-send-email-Shengzhou.Liu@freescale.com>
 <20140522225144.GA1670@home.buserror.net>
 <474028133ffd49cebfeb951498923caa@DM2PR03MB398.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 2014-05-23 at 03:03 -0500, Liu Shengzhou-B36685 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, May 23, 2014 6:52 AM
> > To: Liu Shengzhou-B36685
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
> > 
> > > +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> > > @@ -125,6 +125,11 @@ CONFIG_USB_EHCI_FSL=y  CONFIG_USB_STORAGE=y
> > > CONFIG_MMC=y  CONFIG_MMC_SDHCI=y
> > > +CONFIG_RTC_CLASS=y
> > > +CONFIG_RTC_DRV_CMOS=y
> > > +CONFIG_RTC_DRV_DS1307=y
> > > +CONFIG_RTC_DRV_DS1374=y
> > > +CONFIG_RTC_DRV_DS3232=y
> > >  CONFIG_EDAC=y
> > >  CONFIG_EDAC_MM_EDAC=y
> > >  CONFIG_DMADEVICES=y
> > 
> > Why only corenet64 and not corenet32?
> > 
> > -Scott
> [Shengzhou] There is already RTC support in corenet32, only missing in corenet64.

Only DS3232, not DS1307 or DS1374.  Which boards use the latter two?

Why do we need CONFIG_RTC_DRV_CMOS?

-Scott

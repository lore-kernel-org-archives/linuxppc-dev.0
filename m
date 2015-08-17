Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0102.outbound.protection.outlook.com [157.56.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C67311A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:05:30 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Timur Tabi <timur@tabi.org>, Scott Wood <scottwood@freescale.com>
CC: Jin Jason <Jason.Jin@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-fbdev@vger.kernel.org"
 <linux-fbdev@vger.kernel.org>
Subject: RE: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU
 module
Date: Mon, 17 Aug 2015 06:05:18 +0000
Message-ID: <SN1PR0301MB1616FC248A1601A8D1C530859D790@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
 <55CEB5CB.4060803@tabi.org>
In-Reply-To: <55CEB5CB.4060803@tabi.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Timur.

@Scott,
Could you apply this patch?

Regards,
-Dongsheng

> -----Original Message-----
> From: Timur Tabi [mailto:timur@tabi.org]
> Sent: Saturday, August 15, 2015 11:45 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Jin Zhengxiong-R64188; linuxppc-dev@lists.ozlabs.o=
rg;
> linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL=
 DIU
> module
>=20
> Dongsheng Wang wrote:
> > For deep sleep, the diu module will power off, when wake up from the
> > deep sleep, the registers need to be reinitialized.
> >
> > Signed-off-by: Jason Jin<Jason.Jin@freescale.com>
> > Signed-off-by: Wang Dongsheng<dongsheng.wang@freescale.com>
>=20
> Acked-by: Timur Tabi <timur@tabi.org>

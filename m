Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0103.outbound.protection.outlook.com [207.46.100.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96C901A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 20:02:36 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>
CC: Scott Wood <scottwood@freescale.com>, Jin Jason <Jason.Jin@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Timur Tabi
 <timur@tabi.org>
Subject: RE: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU
 module
Date: Thu, 24 Sep 2015 10:02:28 +0000
Message-ID: <SN1PR0301MB1616D30A83E8A5C6FEE6A44A9D430@SN1PR0301MB1616.namprd03.prod.outlook.com>
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

Hi Tomi,

Could you apply this patch?

> > For deep sleep, the diu module will power off, when wake up from the
> > deep sleep, the registers need to be reinitialized.
> >
> > Signed-off-by: Jason Jin<Jason.Jin@freescale.com>
> > Signed-off-by: Wang Dongsheng<dongsheng.wang@freescale.com>
>=20
> Acked-by: Timur Tabi <timur@tabi.org>

Regards,
-Dongsheng

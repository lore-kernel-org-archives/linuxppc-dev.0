Return-Path: <Jason.Jin@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0C1C71400AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 18:28:36 +1100 (EST)
From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, Scott Wood
 <scottwood@freescale.com>, "timur@tabi.org" <timur@tabi.org>
Subject: RE: [PATCH 2/2] Make the diu driver work without board level
 initilization
Date: Tue, 1 Apr 2014 07:28:28 +0000
Message-ID: <57b9d96d00f64eff90ae6c109c9dec90@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1395920287-5204-1-git-send-email-Jason.Jin@freescale.com>
 <1305603ae9b846d9bc4c78f21a8c0494@BY2PR03MB505.namprd03.prod.outlook.com>
In-Reply-To: <1305603ae9b846d9bc4c78f21a8c0494@BY2PR03MB505.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +	if (!diu_ops.set_pixel_clock) {
> > +		data->pixelclk_reg =3D of_iomap(np, 1);
> > +		if (!data->pixelclk_reg) {
> > +			dev_err(&pdev->dev, "Cannot map pixelclk registers,
> please \
> > +				provide the diu_ops for pixclk setting
> instead.\n");
>=20
> The error message should be in one line if possible, or it will hard to
> grep.
> If cannot, should split it into two or more lines, like:
>  +			dev_err(&pdev->dev, "Cannot map pixelclk registers,\n"
>  +				"please provide the diu_ops for pixclk setting
> instead.\n");
Thanks, This has been fixed in the update version, please help to review it=
 at:
http://patchwork.ozlabs.org/patch/335225/
I forgot to add the V2 information in the subject in the update patch so th=
is may confuse the reviewer, sorry for that.

Best Regards,
Jason=20

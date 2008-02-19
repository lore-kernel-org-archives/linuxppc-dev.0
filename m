Return-Path: <SRS0=kPSl=TI=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id B3D2EDDEFE
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 20:00:12 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Date: Tue, 19 Feb 2008 09:59:40 +0100
References: <4784FED1.2040206@pikatech.com> <47BA3416.5080405@pikatech.com>
	<20080219092321.1fed233d@hyperion.delvare>
In-Reply-To: <20080219092321.1fed233d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802190959.41253.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 February 2008, Jean Delvare wrote:
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index b61f56b..44c0984 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -244,7 +244,6 @@ config I2C_PIIX4
> >
> >  config I2C_IBM_IIC
> >  	tristate "IBM PPC 4xx on-chip I2C interface"
> > -	depends on IBM_OCP
> >  	help
> >  	  Say Y here if you want to use IIC peripheral found on
> >  	  embedded IBM PPC 4xx based systems.
>
> With this Kconfig change, "make menuconfig" lets me select the
> i2c-ibm_iic driver on x86_64, but it fails to build horribly. I think
> that you want to restrict the build to PPC machines somehow, or at
> least make sure that either IBM_OCP or OF support is present.

How about this:

-	depends on IBM_OCP
+	depends on 4xx

Best regards,
Stefan

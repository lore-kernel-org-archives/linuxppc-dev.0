Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id ADC0F474D3
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 05:12:16 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH] I2C driver
Date: Thu, 21 Aug 2008 21:05:29 +0200
References: <48AD9610.8090205@harris.com> <48ADA090.8020100@harris.com>
	<20080821132731.47a2f49a@lappy.seanm.ca>
In-Reply-To: <20080821132731.47a2f49a@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808212105.29963.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 21 August 2008, Sean MacLennan wrote:
> On Thu, 21 Aug 2008 13:06:24 -0400
>
> "Steven A. Falco" <sfalco@harris.com> wrote:
> > However, while the i2c-ibm_of.c driver works with the sequoia .dts,
> > i2c-ibm_iic.c does not, because it is looking for an "index" property,
> > which is not in the .dts file.  I added one:
>
> I don't know where i2c-ibm_of.c came from....

It's a temporary DENX version for arch/powerpc which we created, since it took 
too long to get something accepted upstream (I remember endless discussions 
about index properties...). And we needed something functional quite a while 
ago.

> but in the 2.6.26 kernel 
> you need the index property.
>
> The 2.6.27 kernel has a fully OF aware i2c-ibm_iic driver. You do
> not need the index. And it will walk the device tree and setup the
> devices for you.

Yes. Since 2.6.27 the "original" IBM I2C driver should be enough. We will drop 
our local special version soon.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================

Return-Path: <SRS0=i/5s=R3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 74326DDEE0
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 23:59:14 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c-ibm_iic driver
Date: Sat, 5 Jan 2008 13:58:33 +0100
References: <477EF225.4070505@pikatech.com> <200801051349.34488.sr@denx.de>
	<200801051354.11202.arnd@arndb.de>
In-Reply-To: <200801051354.11202.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801051358.33473.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Arnd Bergmann wrote:
> > > This is probably not specific enough. I'm rather sure that someone at
> > > IBM has implemented an i2c chip that this driver doesn't support. May=
be
> > >
> > > =A0=A0=A0=A0=A0=A0.compatible =3D "ibm,405-iic"
> > >
> > > or similar would be a better thing to check for.
> >
> > =A0=A0=A0=A0=A0=A0=A0=A0.compatible =3D "ibm,4xx-iic"
> >
> > please, since 405 and 440 have the same I2C controller.
>
> But that's not how compatible properties work -- they should not
> contain wildcards. If you have different devices that are
> backwards compatible, you should list the older one in all
> newer devices, e.g. the 440 can list that it is compatible
> with both ibm,405-iic and ibm,440-iic. If there was an earlier
> 401 that had iic as well, you may even want to include that
> in the device tree.

OK. Thanks for clarifying.

Best regards,
Stefan

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 8BAD5DDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 10:55:50 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Date: Wed, 20 Feb 2008 00:54:37 +0100
References: <4784FED1.2040206@pikatech.com> <47BB63AE.2090903@pikatech.com>
	<20080220104133.e9722e62.sfr@canb.auug.org.au>
In-Reply-To: <20080220104133.e9722e62.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200802200054.38282.arnd@arndb.de>
Cc: Jean Delvare <khali@linux-fr.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Stefan Roese <sr@denx.de>, i2c@lm-sensors.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 20 February 2008, Stephen Rothwell wrote:
> > > - =A0 =A0 =A0 depends on IBM_OCP
> > > + =A0 =A0 =A0 depends on IBM_OCP || PPC_MERGE
>=20
> not PPC_OF? =A0or even OF (give the sparc guys the opportunity to build it
> for us :-))?
>=20

Right, I was looking for that option but couldn't find it. I would
guess sparc doesn't work because it's lacking the necessary I/O functions,
in_8 and out_8 that are powerpc specific.

so maybe:
	depends on PPC
	depends on IBM_OCP || OF

	Arnd <><

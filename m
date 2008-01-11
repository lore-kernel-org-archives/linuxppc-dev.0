Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id BD749DE05E
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 01:13:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with device tree binding for SMC serial
Date: Fri, 11 Jan 2008 08:13:49 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D9A092@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D9A042@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com><4785246D.6090206@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com><47854AE1.7080802@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com><47854D6D.2010906@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com><20080110175348.GA4317@loki.buserror.net><DCEAAC0833DD314AB0B58112AD99B93B03D99E60@ismail.innsys.innovsys.com><47866FDE.5070307@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D9A042@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Rune Torgersen
> Finally got it (sort-of) working.
> Turned out that for some reason the console init is setting=20
> the baudrate
> to 9600
> the options string passed in to the console init fuunction is NULL.
>=20
> Any idea oon how this should be passed in from u-boot?

Ok, needed a valid console=3D line on the command line. WHen we tried
that, we had a typo, so it was not recognized.
Our old 2.6.18 arch/ppc kernel didn't need a console parameter, it got
the baudrate from u-boot somehow.
Anyway of doing that here too?

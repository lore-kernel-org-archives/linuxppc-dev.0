Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id C0792DE123
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 05:11:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with device tree binding for SMC serial
Date: Fri, 11 Jan 2008 12:11:19 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D9A37A@ismail.innsys.innovsys.com>
In-Reply-To: <4787A663.2020902@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com><4785246D.6090206@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com><47854AE1.7080802@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com><47854D6D.2010906@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com><20080110175348.GA4317@loki.buserror.net><DCEAAC0833DD314AB0B58112AD99B93B03D99E60@ismail.innsys.innovsys.com><47866FDE.5070307@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D9A042@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D9A092@ismail.innsys.innovsys.com>
	<4787A663.2020902@freescale.com>
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

> From: Scott Wood=20
>=20
> You could add something to the cuboot code to fill in current-speed=20
> based on the value in the bd_t.
>=20

Ahh.. That was what I'm missing.
Where in the devicetree is that supposed to be at?

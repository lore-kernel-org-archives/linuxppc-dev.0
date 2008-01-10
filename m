Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 6B998DE032
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 06:10:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with device tree binding for SMC serial
Date: Thu, 10 Jan 2008 13:10:26 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D99E60@ismail.innsys.innovsys.com>
In-Reply-To: <20080110175348.GA4317@loki.buserror.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
	<47854AE1.7080802@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com>
	<47854D6D.2010906@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com>
	<20080110175348.GA4317@loki.buserror.net>
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

> From: Scott Wood
>=20
> The tree looks OK.  The checkstop may be from erratum SIU18;
> I had this issue on the ep8248e board.
>=20
> Try clearing BCR[PLDP].

Not sure what was wrong. We took a step back, and redid some stuff, and
now we have serial output from the boot-wrapper.
THe checkstop came from the wrapper grying to access the bcsr and doing
the chip select fixup. We don';t have a bcsr on our board, and the cs
layout is different.

Now our problem is that the kernel doesn't want to output anything to
hte serial port.

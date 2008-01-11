Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB780DE06D
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 04:25:25 +1100 (EST)
Message-ID: <4787A663.2020902@freescale.com>
Date: Fri, 11 Jan 2008 11:24:51 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Help with device tree binding for SMC serial
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com><4785246D.6090206@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com><47854AE1.7080802@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com><47854D6D.2010906@freescale.com><DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com><20080110175348.GA4317@loki.buserror.net><DCEAAC0833DD314AB0B58112AD99B93B03D99E60@ismail.innsys.innovsys.com><47866FDE.5070307@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D9A042@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D9A092@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D9A092@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Ok, needed a valid console= line on the command line. WHen we tried
> that, we had a typo, so it was not recognized.
> Our old 2.6.18 arch/ppc kernel didn't need a console parameter, it got
> the baudrate from u-boot somehow.
> Anyway of doing that here too?

You could add something to the cuboot code to fill in current-speed 
based on the value in the bd_t.

-Scott

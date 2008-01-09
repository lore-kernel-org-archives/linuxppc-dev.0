Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C38D5DE024
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 09:41:02 +1100 (EST)
Message-ID: <47854D6D.2010906@freescale.com>
Date: Wed, 09 Jan 2008 16:40:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Help with device tree binding for SMC serial
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
	<47854AE1.7080802@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com>
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
>> From: Scott Wood
>> Don't forget to exclude the SMC parameter RAM from the muram 
>> data area 
>> in /soc/cpm/muram/data/reg.  If you have an older device tree binding 
>> that has no /soc/cpm/muram node, but instead has two resources in 
>> /soc/cpm/reg, you need to move to head-of-tree to get this to work.
> 
> Did that, now we get e checkstop resert. Time to hook up the
> BDI-2000....
> Is there a way to have the bootwrapper use the u-boot serial for a while
> (like a early srial port) for debugging?

If you mean calling into u-boot for a console, no, there's no code for that.

What do your cpm and muram nodes look like?

-Scott

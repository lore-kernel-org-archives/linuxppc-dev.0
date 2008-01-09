Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 5BCD9DDFE8
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 09:37:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with device tree binding for SMC serial
Date: Wed, 9 Jan 2008 16:37:38 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com>
In-Reply-To: <47854AE1.7080802@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
	<47854AE1.7080802@freescale.com>
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
> Don't forget to exclude the SMC parameter RAM from the muram=20
> data area=20
> in /soc/cpm/muram/data/reg.  If you have an older device tree binding=20
> that has no /soc/cpm/muram node, but instead has two resources in=20
> /soc/cpm/reg, you need to move to head-of-tree to get this to work.

Did that, now we get e checkstop resert. Time to hook up the
BDI-2000....
Is there a way to have the bootwrapper use the u-boot serial for a while
(like a early srial port) for debugging?

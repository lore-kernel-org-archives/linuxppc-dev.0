Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B16BDDEF0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 05:13:01 +1100 (EST)
Date: Fri, 18 Jan 2008 11:07:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Problems with PCI on 8280
Message-ID: <20080118170723.GA3898@loki.buserror.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D4@ismail.innsys.innovsys.com>
	<478FD066.5000803@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B039BA0D6@ismail.innsys.innovsys.com>
	<478FE248.1030101@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B039BA0D8@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D8@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2008 at 06:27:46PM -0600, Rune Torgersen wrote:
> BTW. there is a bug in the inbound window size calculation. The mem_log2
> variable sould be the shift value, not 1<< shift. and on the next line the
> window size mask sould be anded with 0x000f_ffff before or'ed with
> 0xa000_0000

D'oh.  Thanks for spotting it!

-Scott

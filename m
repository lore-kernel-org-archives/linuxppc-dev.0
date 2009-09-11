Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AC6E7B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 15:40:37 +1000 (EST)
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pravin Bathija <pbathija@amcc.com>
In-Reply-To: <9D1E2BDCB5C57B46B56E6D80843439EB0580C926@SDCEXCHANGE01.ad.amcc.com>
References: <1251926572.10090.17.camel@Adam> <200909110712.11858.sr@denx.de>
	<1252646270.8566.64.camel@pasglop> <200909110725.36208.sr@denx.de>
	<9D1E2BDCB5C57B46B56E6D80843439EB0580C926@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 15:40:21 +1000
Message-Id: <1252647621.8566.67.camel@pasglop>
Mime-Version: 1.0
Cc: Andrea Zypchen <azypchen@intldata.ca>, lebon@lebon.org.ua,
	Prodyut Hazarika <phazarika@amcc.com>, tburns@datacast.com,
	Stefan Roese <sr@denx.de>, linuxppc-dev@lists.ozlabs.org,
	azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-10 at 22:35 -0700, Pravin Bathija wrote:
> Thanks Stefan. The whole intention of the patch/hack (or whatever one
> might call it :) ) was to avoid rogue drivers from setting
> pci_cache_line_size to non-zero value even though the underlying
> hardware doesn't support MRM calls. Nonetheless this approach works
> only if the drivers use the kernel API for PCI config space access
> provided by the powerpc platform driver.
> 
Do you know many drivers that do config space accesses without using
the config space accessors ?

Such drivers should be banned to oblivion.

Cheers,
Ben.

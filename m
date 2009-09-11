Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0739AB70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 15:18:08 +1000 (EST)
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200909110712.11858.sr@denx.de>
References: <1251926572.10090.17.camel@Adam>
	<9D1E2BDCB5C57B46B56E6D80843439EB090397EC@SDCEXCHANGE01.ad.amcc.com>
	<1252637074.8566.56.camel@pasglop>  <200909110712.11858.sr@denx.de>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 15:17:50 +1000
Message-Id: <1252646270.8566.64.camel@pasglop>
Mime-Version: 1.0
Cc: Andrea Zypchen <azypchen@intldata.ca>, Pravin Bathija <pbathija@amcc.com>,
	lebon@lebon.org.ua, Prodyut Hazarika <phazarika@amcc.com>,
	tburns@datacast.com, linuxppc-dev@lists.ozlabs.org, azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-11 at 07:12 +0200, Stefan Roese wrote:
> 
> It's already there. See commit:
> 
> 5ce4b59653b2c2053cd9a011918ac1e4747f24cc
> 
> powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata
> 
Ok, that's another way to do it. Will catch nasty drivers who
try to write directly rather than clear pci_cache_line_size I suppose...

Cheers,
Ben.

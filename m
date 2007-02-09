Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DBB3DDEE0
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 10:19:33 +1100 (EST)
Subject: Re: Discussion about iopa()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45CCFF4B.7000102@freescale.com>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<1170969965.2620.345.camel@localhost.localdomain>
	<0640B069-F05E-4A08-A8EB-C277BEF1466E@embeddedalley.com>
	<1171058780.6578.4.camel@localhost.localdomain>
	<1EFFAE36-7396-45B5-B8F2-DD7348FBE385@kernel.crashing.org>
	<45CCFAD6.5070807@freescale.com>
	<7B89E9E3-620C-4DF5-96E7-AF05287D89DC@kernel.crashing.org>
	<45CCFF4B.7000102@freescale.com>
Content-Type: text/plain
Date: Sat, 10 Feb 2007 10:19:19 +1100
Message-Id: <1171063159.6578.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-09 at 17:10 -0600, Timur Tabi wrote:
> Kumar Gala wrote:
> 
> > It doesn't seem like it's that big of a change.  I'd rather the code 
> > clearly do different things for MURAM vs system memory for ALL accesses.
> 
> Why?  MURAM acts like RAM, it just needs to be mapped first.

Specific allocator, no struct pages, etc.... no, it's not just like RAM.

Ben.

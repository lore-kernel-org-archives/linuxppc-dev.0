Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3387DDF6A
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 02:41:28 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8PGfJhR020684
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 09:41:20 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8PGfJiO016025
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 11:41:19 -0500 (CDT)
Date: Thu, 25 Sep 2008 11:41:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible SOC
	GPIOs
Message-ID: <20080925164118.GA4435@ld0162-tx32.am.freescale.net>
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
	<20080918112020.GA11584@oksana.dev.rtsoft.ru>
	<87ej3gyxv0.fsf@macbook.be.48ers.dk>
	<20080919153325.GA548@oksana.dev.rtsoft.ru>
	<1BA571BA-BA43-4C18-9CBF-0F1461E6734E@kernel.crashing.org>
	<20080919181258.GA14093@oksana.dev.rtsoft.ru>
	<ABD97D30-4503-4A5E-A04B-2D644BF31124@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ABD97D30-4503-4A5E-A04B-2D644BF31124@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 01:46:49PM -0500, Kumar Gala wrote:
> You are correct we try to avoid this, but than I suggest we do it by  
> family.  I think its confusing to show 8610 and 8349 in the same dev  
> tree.

I don't think it's confusing (at least, not moreso than picking an
arbitrary chip within the same family), if it really is compatible and
there is nothing new in the 86xx GPIO that warrants having a common
compatible for them.

-Scott

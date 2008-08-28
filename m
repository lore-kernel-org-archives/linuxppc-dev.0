Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38B35DE0C1
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 04:13:23 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m7SID0EB012003
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 11:13:17 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m7SGfhko022338
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 11:41:43 -0500 (CDT)
Date: Thu, 28 Aug 2008 11:41:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: RFC: Could cpm2_clk_setup and cpm2_set_pin be exported ?
Message-ID: <20080828164142.GB1185@ld0162-tx32.am.freescale.net>
References: <200808281757.16903.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200808281757.16903.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 28, 2008 at 05:57:13PM +0200, Laurent Pinchart wrote:
> I'm facing a situation where I need to call cpm2_clk_setup and
> cpm2_set_pin from a device driver compiled as a module. Before
> submitting a patch to export both functions, I'd like to make sure
> there isn't a cleaner way to implement the desired functionality
> without calling functions that are supposed to be used by board setup
> code.

Have you looked at using the GPIO API?

-Scott

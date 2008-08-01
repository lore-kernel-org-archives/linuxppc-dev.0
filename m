Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5D339DF02B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 04:50:13 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m71Io8VH003562
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 11:50:08 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m71InqSt008903
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 13:49:52 -0500 (CDT)
Date: Fri, 1 Aug 2008 13:49:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/8] powerpc: add the ability for a classic ppc kernel to
	be loaded at 32M
Message-ID: <20080801184952.GA25225@ld0162-tx32.am.freescale.net>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
	<20080801141420.GD1161@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080801141420.GD1161@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 01, 2008 at 06:14:20PM +0400, Anton Vorontsov wrote:
> From: Dale Farnsworth <dale@farnsworth.org>
> 
> Add the ability for a classic ppc kernel to be loaded at an address
> of 32MB.  This done by fixing a few places that assume we are loaded
> at address 0, and by changing several uses of KERNELBASE to use
> PAGE_OFFSET, instead.

What do you do about the exception vectors?

-Scott

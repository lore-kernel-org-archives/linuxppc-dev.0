Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D89B0DE115
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 06:01:40 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2CJ118V001089
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 12:01:02 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n2CJ11hD007649
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 14:01:01 -0500 (CDT)
Message-ID: <49B95BEC.2010404@freescale.com>
Date: Thu, 12 Mar 2009 14:01:00 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Confused about CLOCK_TICK_RATE
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can someone explain CLOCK_TICK_RATE to me?  It's defined in
arch/powerpc/include/asm/timex.h as such:

#define CLOCK_TICK_RATE	1024000 /* Underlying HZ */

Every architecture defines this, but some use the better comment
"Underlying frequency of the HZ timer".

My question is: why is this a constant? Shouldn't it be a variable,
perhaps something that is based on tb_ticks_per_usec?

-- 
Timur Tabi
Linux kernel developer at Freescale

Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC59BB7B78
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 05:13:33 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9EIDU9s025283
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 11:13:30 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n9EIG0GV029341
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 13:16:01 -0500 (CDT)
Message-ID: <4AD614E4.6030005@freescale.com>
Date: Wed, 14 Oct 2009 13:13:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: UBIFS problem on MPC8536DS
References: <4AD5ADC9.30503@embedded-sol.com>	<4AD5C5B4.3060303@nokia.com>	<4AD5D053.9000901@embedded-sol.com>	<4AD5FFE7.7080703@nokia.com>
	<4AD60EF4.4080306@embedded-sol.com>
In-Reply-To: <4AD60EF4.4080306@embedded-sol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Adrian Hunter <adrian.hunter@nokia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felix Radensky wrote:
> Yes, NAND and NOR are on the same local bus controller.
> 
> Maybe powerpc folks can provide some insight here.
> Is it possible that simultaneous access to NOR and NAND
> on MPC8536 can result in NAND timeouts ?

I've heard other reports of such problems with eLBC, but was unable to 
reproduce it myself last time I tried.  Could you reduce this down to a 
minimal set of specific reproduction instructions (e.g. eliminate UBI if 
possible, or else explain how to set up UBI)?

-Scott

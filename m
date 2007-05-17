Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37509DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 04:59:35 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4HIxVKB013036
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 11:59:31 -0700 (MST)
Message-ID: <464CA610.1050504@freescale.com>
Date: Thu, 17 May 2007 13:59:28 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>
	<464CA302.9060707@freescale.com> <464CA380.2020705@freescale.com>
	<464CA4B4.7070202@freescale.com>
In-Reply-To: <464CA4B4.7070202@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> We also don't want people using a perfectly good device tree on a newer 
> revision of the board that just fixes things and doesn't make any 
> device-tree-relevant changes,

Well, either one device tree is okay, or we need two.  If we do need two, then it would be 
bad to load the wrong one on a particular board and have only 90% functionality.  If he 
have the ability to prevent customers from getting confused, then we should do that.  I 
wish this was standard behavior for all device trees.  I've frequently loaded the wrong 
device tree and wondered why nothing worked.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

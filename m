Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4D67DDF19
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 23:48:36 +1000 (EST)
Message-ID: <464DAEC9.2040508@genesi-usa.com>
Date: Fri, 18 May 2007 14:48:57 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>	<464CA302.9060707@freescale.com>
	<464CA380.2020705@freescale.com>	<464CA4B4.7070202@freescale.com>
	<464CA610.1050504@freescale.com>
In-Reply-To: <464CA610.1050504@freescale.com>
Content-Type: text/plain; charset=UTF-8
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


Timur Tabi wrote:
> Scott Wood wrote:
> 
>> We also don't want people using a perfectly good device tree on a newer 
>> revision of the board that just fixes things and doesn't make any 
>> device-tree-relevant changes,
> 
> Well, either one device tree is okay, or we need two.  If we do need two, then it would be 
> bad to load the wrong one on a particular board and have only 90% functionality.  If he 
> have the ability to prevent customers from getting confused, then we should do that.  I 
> wish this was standard behavior for all device trees.  I've frequently loaded the wrong 
> device tree and wondered why nothing worked.

Another design win for dynamically generated firmware device trees and
a knock on the head for writing text files and hoping they match the
hardware description? :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

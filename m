Return-Path: <muli@granada.merseine.nu>
Received: from mtaout4.012.net.il (mtaout4.012.net.il [84.95.2.10])
	by ozlabs.org (Postfix) with ESMTP id 6E9E167A3E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 03:32:10 +1000 (EST)
Received: from granada.merseine.nu ([87.69.40.180])
	by i_mtaout4.012.net.il (HyperSendmail v2004.12)
	with ESMTP id <0IXO00F348UPP530@i_mtaout4.012.net.il> for
	linuxppc-dev@ozlabs.org; Thu, 13 Apr 2006 20:35:13 +0300 (IDT)
Date: Thu, 13 Apr 2006 20:31:21 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
	V2
In-reply-to: <20060413160712.GG24769@pb15.lixom.net>
To: Olof Johansson <olof@lixom.net>
Message-id: <20060413173121.GJ10412@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
	<20060413160712.GG24769@pb15.lixom.net>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2006 at 11:07:12AM -0500, Olof Johansson wrote:

> Walking the DT means we need to hardcode it on PCI IDs, since the Apple
> OF doesn't give the Airport device a logical name. It's probably easier
> to implement than walking PCI, but we'd need to maintain a table. My
> vote is for PCI walking, I'll give that a shot over the weekend.

Cool! bonus points if you do it in drivers/pci and we can steal it
easily for Calgary on x8-64 :-)

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

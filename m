Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44B6BDDEC0
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2007 01:50:31 +1000 (EST)
In-Reply-To: <11825407952085-git-send-email-timur@freescale.com>
References: <11825407952085-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx,
	and 86xx device trees
Date: Sat, 23 Jun 2007 17:50:23 +0200
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> For the 83xx, 85xx, and 86xx device trees, add a "local-mac-address" 
> property
> to every Ethernet node that didn't have one.  Add a comment indicating 
> that
> the "address" and/or "mac-address" properties are deprecated in DTS 
> files
> and will be removed at a later time.  Change all MAC address 
> properties to
> have a zero MAC address value.

Shouldn't you use the "??" notation instead, or is that
still not implemented?

Otherwise, looks good, ACK.

[I would have preferred if you had removed "address" right
away (replaced by "mac-address"), but since it is marked
for removal anyway, that's fine with me].


Segher

Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F654DE005
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:56:18 +1100 (EST)
In-Reply-To: <20070129201211.GL13485@ld0162-tx32.am.freescale.net>
References: <20070129201211.GL13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <55FE15EB-8FA6-4819-B3DE-5F72A423F3CC@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 12/18] bootwrapper: Make ft_get_parent() return a phandle,
	and NULL if already top-level.
Date: Tue, 30 Jan 2007 20:56:10 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It also now returns NULL as the parent of the toplevel node, rather  
> than
> just returning the toplevel node again (which made it rather  
> useless in
> loops).

Great, that's how "real" OF handles this as well.  In
a similar vein, peer(0) should return the root node --
does it?


Segher

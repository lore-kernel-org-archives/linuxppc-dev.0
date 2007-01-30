Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AE3EDDFAA
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:49:50 +1100 (EST)
In-Reply-To: <20070129201204.GH13485@ld0162-tx32.am.freescale.net>
References: <20070129201204.GH13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4632EC74-4803-4D71-A4EF-538FBCFAA06F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 08/18] bootwrapper: Modify *pp, not *p, in ft_shuffle().
Date: Tue, 30 Jan 2007 20:49:41 +0100
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

> Move the caller's pointer back to match the change in the region's  
> start,
> rather than alter a byte of the device tree's content.

Maybe you could change the variable names too, so it
would be harder to make such obvious coding mistakes?

> -		*p -= nextra;
> +		*pp -= nextra;


Segher

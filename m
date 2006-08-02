Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5EE1767B90
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 15:30:47 +1000 (EST)
In-Reply-To: <20060801194411.GA22933@kvasir.watson.ibm.com>
References: <20060801194411.GA22933@kvasir.watson.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <55183EF7-73CF-427E-A720-9CA67AB00DD4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] turn on tigon3 support in maple_defconfig
Date: Wed, 2 Aug 2006 07:30:29 +0200
To: Amos Waterland <apw@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think that most people who use maple_defconfig are doing so for a  
> JS21,
> so it might make sense to turn Tigon3 support on by default.

Also needed on JS20.

> Built and booted on a JS21.
>
> Signed-off-by: Amos Waterland <apw@us.ibm.com>

ACK.


Segher

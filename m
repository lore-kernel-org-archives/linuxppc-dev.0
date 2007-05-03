Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 922E6DE017
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 03:38:18 +1000 (EST)
Message-ID: <463A1E02.3000704@freescale.com>
Date: Thu, 03 May 2007 12:38:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
References: <1178142818.32136.51.camel@ld0161-tx32>	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>	<1178207725.17201.33.camel@ld0161-tx32>	<20070503161000.GA31881@lixom.net>	<1178209046.17201.55.camel@ld0161-tx32>
	<20070503172657.GA32312@lixom.net>
In-Reply-To: <20070503172657.GA32312@lixom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Thu, May 03, 2007 at 11:17:26AM -0500, Jon Loeliger wrote:
>>Why do it there?  We'd have to do it _again_ in Linux
>>if we didn't come in from U-Boot anyway.
> 
> The same argument could be used to motivate not doing any kind of board
> inits in any firmware and do it all from the board code in linux.

Not to mention that it's more likely that someone will use a different 
OS than different firmware, and then they'd have to duplicate the board 
code *there*.

-Scott

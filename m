Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 638D9DDD0D
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 05:19:09 +1000 (EST)
In-Reply-To: <9050bda20708191111n497e1565h87eb9a2423a6ba56@mail.gmail.com>
References: <9050bda20708191111n497e1565h87eb9a2423a6ba56@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e034e26666986dc56279ab552d80fbe7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: LINKSTATION default config update for linux-2.6.23-rc3
Date: Sun, 19 Aug 2007 21:18:59 +0200
To: "Jonathan Li" <jonli447@gmail.com>
Cc: linuxppc-dev@ozlabs.org, g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Please update the default config in linux-2.6.23 for the LINKSTATION
> board with the following changes:
>
> SK98LIN SysKonnect driver is deprecated.  Use SKGE instead.

/me confused...

None of SK98LIN, SKGE, SKY2 are in the linkstation_defconfig --
not unsurprisingly, since the hardware doesn't contain any such
chip.


Segher

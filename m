Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3158E2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 09:27:05 +1100 (EST)
Date: Thu, 13 Jan 2005 22:58:08 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andy Fleming <afleming@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>, Netdev <netdev@oss.sgi.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <20050113215808.GA15124@wohnheim.fh-wedel.de>
References: <FC6D9B81-5514-11D9-8D51-000393C30512@freescale.com>
	<A3A281FF-5525-11D9-80ED-000393C30512@freescale.com>
	<20050106070245.GA6539@gate.ebshome.net>
	<61A37C72-659C-11D9-8D70-000393C30512@freescale.com>
	<20050113212152.GA16041@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050113212152.GA16041@gate.ebshome.net>
Subject: Re: [RFC] Patch to Abstract Ethernet PHY support (using driver
	model)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 13 January 2005 13:21:52 -0800, Eugene Surovegin wrote:
> 
> It's a standard, period. If there is a PHY which isn't compliant I
> guess it will not work anyway, but in this case, yes, we can use
> PHY-specific link detection, but only in this case. I suspect you'll
> have a hard time finding such PHY :)

http://www.broadcom.com/collateral/pb/5325-PB05-R.pdf

With some thinking and very little code, you can use this neat chip
almost like a normal phy.

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 

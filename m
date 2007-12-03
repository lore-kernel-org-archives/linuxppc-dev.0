Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB73ADDEC2
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 08:04:23 +1100 (EST)
Subject: Re: [PATCH] Add IPIC MSI interrupt support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Li <r64360@freescale.com>
In-Reply-To: <1196672870.14353.21.camel@Guyver>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
	<1196672870.14353.21.camel@Guyver>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 08:03:32 +1100
Message-Id: <1196715812.13230.234.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>, Li Tony <Tony.Li@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-03 at 17:07 +0800, Li Li wrote:
> 
> In IPIC, the 8 MSI interrupts is handled as level intrrupt.
> I just provide a versatile in case it is changed.

Level ? Are you sure ? MSIs are by definition edge interrupts... Or do
you have some weird logic that asserts a level input until you go ack
something ? Sounds weird...

Ben.

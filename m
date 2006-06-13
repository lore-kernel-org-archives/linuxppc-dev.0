Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEEB567B30
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 19:58:52 +1000 (EST)
Subject: Re: pmf_register_irq_client gives sleep with locks held warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1150188199.9208.7.camel@johannes>
References: <1149020341.5128.7.camel@johannes>
	<1149123574.15446.15.camel@localhost.localdomain>
	<1149793098.11525.34.camel@johannes>
	<1149897784.12687.87.camel@localhost.localdomain>
	<1149931638.3864.34.camel@johannes.berg>
	<1149977097.12687.144.camel@localhost.localdomain>
	<1150188199.9208.7.camel@johannes>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 19:58:33 +1000
Message-Id: <1150192713.13958.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I see your patch is in, I'll make a patch that fixes it then instead of
> replacing it, I guess.

Please do, thanks.

Ben.

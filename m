Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FF0467A6E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 10:33:34 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <4230D7F4.8060900@pobox.com>
References: <1107b64b01fb8e9a6c84359bb56881a6@freescale.com>
	<1110334456.32556.21.camel@gaston>
	<20050308194229.41c23707.davem@davemloft.net>
	<1110340214.32524.32.camel@gaston>
	<57a429f8eb807987d88b06129861d507@freescale.com>
	<4230D1AC.5070506@katalix.com> <1110495992.32525.290.camel@gaston>
	<4230D7F4.8060900@pobox.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 10:27:47 +1100
Message-Id: <1110497267.32524.295.camel@gaston>
Mime-Version: 1.0
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: RFC: PHY Abstraction Layer II
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-03-10 at 18:27 -0500, Jeff Garzik wrote:

> I haven't had time to review the phy abstraction layer, but my gut 
> feeling is that there are several common code patterns which could be 
> abstracted out, to save code.
> 
> Typically there will be one or more phy-specific functions in each 
> 10/100 or GigE driver, falling back to a default 'genphy' driver when 
> things are completely MII/GMII-compatible.

Exactly. One thing for which i usually need PHY specific functions
(pretty much all the time) is PHY init (thanks Broadcom) and suspend.

Ben.

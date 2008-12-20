Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2061DDF15
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 14:36:13 +1100 (EST)
Subject: Re: 970FX thermal diode on G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <494C5E6A.6030207@hypersurf.com>
References: <494C5E6A.6030207@hypersurf.com>
Content-Type: text/plain
Date: Sat, 20 Dec 2008 14:35:53 +1100
Message-Id: <1229744153.13001.50.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-12-19 at 18:54 -0800, Kevin Diggs wrote:
> Hi,
> 
> 	Is the thermal diode on a 970FX used on a G5? Can it be read by software?

The existing thermal control should do all you need already :-)

Cheers,
Ben.

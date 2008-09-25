Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E2BEDDF55
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 18:34:46 +1000 (EST)
Subject: Re: MPC5200 PCI interrupt routing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Beisert <jbe@pengutronix.de>
In-Reply-To: <200809250951.15941.jbe@pengutronix.de>
References: <200809221556.34353.jbe@pengutronix.de>
	<20080924181542.GA9690@secretlab.ca> <1222291345.8277.92.camel@pasglop>
	<200809250951.15941.jbe@pengutronix.de>
Content-Type: text/plain
Date: Thu, 25 Sep 2008 18:34:40 +1000
Message-Id: <1222331680.8277.181.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> But how to deal with platform specific things like (in this case) unknown 
> external clock or usage of the internal clock generator (= how to setup the 
> frequency divider)?

You can always use the platform feature hacks like I do on powermac but
we should definitely find something better. Maybe some hook in the OF
wrapper ?

Ben.

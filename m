Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35CF3DDF06
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 12:10:07 +1000 (EST)
Subject: Re: Time disparity on Mac Mini
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Florian Fainelli <florian.fainelli@int-evry.fr>
In-Reply-To: <200703282231.02801.florian.fainelli@int-evry.fr>
References: <200703281951.11561.florian.fainelli@int-evry.fr>
	<200703282231.02801.florian.fainelli@int-evry.fr>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 12:09:59 +1000
Message-Id: <1175134200.32220.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-28 at 22:31 +0200, Florian Fainelli wrote:
> Hello All,
> 
> So as I started writing and sent by mistake. My Mac Mini has a time disparity 
> of 1 minute every 10 (shown) minutes. I do not know if it has something to do 
> with the heat, or if it is a RTC problem. My iBook G4 which is a very similar 
> hardware does not have this problem.
> 
> If any of you as an idea, I will take it ;)

Probably a similar problem to what was reported on debian-ppc recently.
Somebody really need to write a timebase calibration routine using the
KeyLargo timers and see if that improves things ...

Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A65FDDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 06:40:31 +1100 (EST)
Subject: Re: Front LED on Mac mini G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Florian Fainelli <florian.fainelli@int-evry.fr>
In-Reply-To: <200702201433.12851.florian.fainelli@int-evry.fr>
References: <200702201433.12851.florian.fainelli@int-evry.fr>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 06:40:24 +1100
Message-Id: <1172000424.18571.123.camel@localhost.localdomain>
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

On Tue, 2007-02-20 at 14:33 +0100, Florian Fainelli wrote:
> Hi all,
> 
> I would like to know whether it is possible or not to modify the via-pmu-led 
> driver to make it work with the Mac mini G4 front LED, is there anything 
> particular with this model ?

Last I tried, the usual LED control PMU command didn't work on the Mac
Mini. I don't know if there's an alternative.

> By the way, why is this driver only available as in-kernel and not module ?

Ben.

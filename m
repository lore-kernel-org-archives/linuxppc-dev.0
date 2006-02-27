Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBDF467A2E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 08:53:26 +1100 (EST)
Subject: Re: copying /sys causes fans to spin up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060227215023.GA21932@suse.de>
References: <20060227160911.GA17569@suse.de>
	<1141075795.4809.15.camel@localhost.localdomain>
	<20060227213435.GA21832@suse.de> <20060227213612.GB21832@suse.de>
	<1141076553.4809.18.camel@localhost.localdomain>
	<20060227215023.GA21932@suse.de>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 08:53:36 +1100
Message-Id: <1141077217.4809.19.camel@localhost.localdomain>
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

On Mon, 2006-02-27 at 22:50 +0100, Olaf Hering wrote:
>  On Tue, Feb 28, Benjamin Herrenschmidt wrote:
> 
> > 
> > > windfarm: failed to attach ds1775 hd-temp to i2c
> > > windfarm: failed to attach MAX6690 sensor
> > > 
> > > 
> > > Maybe thats harmless, but I have seen it on a few different G5.
> > 
> > Hrm... the windfarm sensors are useless on those old G5s that use
> > therm_pm72... though I wouldn't have expected them to cause harm.
> 
> Its compiled into the kernel, too much trouble if they are not loaded by
> accident.

Yeah, I should add a test for supported machines... 

Ben.

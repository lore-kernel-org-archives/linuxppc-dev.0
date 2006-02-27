Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2074D679A6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 08:50:28 +1100 (EST)
Date: Mon, 27 Feb 2006 22:50:23 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: copying /sys causes fans to spin up
Message-ID: <20060227215023.GA21932@suse.de>
References: <20060227160911.GA17569@suse.de>
	<1141075795.4809.15.camel@localhost.localdomain>
	<20060227213435.GA21832@suse.de> <20060227213612.GB21832@suse.de>
	<1141076553.4809.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1141076553.4809.18.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Feb 28, Benjamin Herrenschmidt wrote:

> 
> > windfarm: failed to attach ds1775 hd-temp to i2c
> > windfarm: failed to attach MAX6690 sensor
> > 
> > 
> > Maybe thats harmless, but I have seen it on a few different G5.
> 
> Hrm... the windfarm sensors are useless on those old G5s that use
> therm_pm72... though I wouldn't have expected them to cause harm.

Its compiled into the kernel, too much trouble if they are not loaded by
accident.

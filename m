Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59F41DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 23:40:49 +1000 (EST)
In-Reply-To: <200706161504.41168.mb@bu3sch.de>
References: <200706141739.12754.mb@bu3sch.de>
	<1181955074.26853.105.camel@localhost.localdomain>
	<200706161504.41168.mb@bu3sch.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <eb7515dbdeec906704d8139424ceee4a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Powerbook hard shutdown after boot if it's hot
Date: Sat, 16 Jun 2007 15:40:39 +0200
To: Michael Buesch <mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think this powerdown is not really related to the adt chip/driver.
> I think it's more likely some PMU issue and the PMU forces the machine
> down. How's the PMU involved into temperatures? Does it get
> the temperature values from the adt chip?

It is connected to the overtemp alarm interrupt pin of
the temperature sensors at least.

Does this shutdown only happen if you boot Linux while
you were running Linux before, too?


Segher

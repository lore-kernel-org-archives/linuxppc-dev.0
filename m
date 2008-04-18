Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 088EADDFAE
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 18:24:26 +1000 (EST)
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48076A00.1080608@genesi-usa.com>
References: <1208105558.3026.137.camel@pmac.infradead.org>
	<4807427B.3030902@genesi-usa.com>
	<1208443057.9212.250.camel@pmac.infradead.org>
	<48076A00.1080608@genesi-usa.com>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 18:24:08 +1000
Message-Id: <1208507048.6958.407.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-17 at 16:17 +0100, Matt Sealey wrote:
> 
> I said the kernel has had braindead patches shoved into it that sort
> of
> obviate the need for the most heinous of crimes committed in the Efika
> device tree.
> 
> The Linux kernel fixups don't add the CDM or XLB arbiter or many other
> components some out-of-mainline drivers will need (and should be able
> to just access without writing a fixup first) to map to work properly.
> Adding these will clean up things like the UART module, Sylvain's
> sleep
> patches will work on Efika, etc.

What about you guys fix the firmware once for all instead of spamming
our mailboxes ?

> > can't set environment variables from within Linux (and yes, we can
> > probably improve on that too, but we let them setenv for themselves,
> for
> > now).
> 
> You really won't be improving on it because there's no reliable way to
> pass setenv back to the firmware from userland :D

They aren't in nvram ? If they are and using the standard OF CHRP
format, then we can.

Ben.

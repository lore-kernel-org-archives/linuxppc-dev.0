Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F06AEDDEDA
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 05:51:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l45Jm2iw028195
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 15:48:02 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45JpI9H185786
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 13:51:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45JpHFp001225
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 13:51:18 -0600
Subject: Re: [PATCH v2 6/7] Holly DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070505191306.GB23524@lixom.net>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
	<e1d22829fe3f12509018791541073706@kernel.crashing.org>
	<20070505191306.GB23524@lixom.net>
Content-Type: text/plain
Date: Sat, 05 May 2007 14:46:04 -0500
Message-Id: <1178394364.3393.54.camel@zod.rchland.ibm.com>
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

On Sat, 2007-05-05 at 14:13 -0500, Olof Johansson wrote:
> > > +  	tsi109@c0000000 {
> > > +		device_type = "tsi-bridge";
> > 
> > Don't put a "device_type" here, it is useless
> > (and undefined).  There are more like this, but
> > perhaps Linux (wrongly) probes on "device_type"
> > for those, so the kernel would need updating
> > first.
> 
> Josh is just using the precedence that the other platform gives, the
> driver is keying off of device_type. While that should be fixed, that's
> a separate issue. I'm sure they'd welcome a driver patch from you.

Right.  I'm not saying it _has_ to be device_type or anything.  It's
simply what the current in-tree functions key off of.  And if that needs
to be fixed, that's fine too.  I just don't think it's a prerequisite
for getting the Holly platform patches merged.

> 
> (Does anyone know if there's an actual firmware out there with the
> tsi-bridge device_type set, and thus just changing DTS's won't help? We'd
> still need to be able to boot/probe the device on those firmwares.)

I'm not sure.  I know PIBS doesn't _currently_ do anything with the DT
on this board, but I think work is on-going there.  As for the FSL
board, I have no idea.  Perhaps U-Boot is doing something there?

> 
> > > +		bus-frequency = <0>;
> > 
> > 0?
> 
> Filled in by bootloader/wrapper? Other dts'es are similar. Could be nice
> to have a comment next to it if that's the case.

No, it's just leftover.  It can be pulled.

josh

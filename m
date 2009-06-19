Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CF42AB7263
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 08:59:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A820DDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 08:59:28 +1000 (EST)
Subject: Re: [PATCH] of_serial: Add UPF_FIXED_TYPE flag
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1245399861.10629.194.camel@concordia>
References: <1244590787-13716-1-git-send-email-dmitchell@amcc.com>
	<1245399861.10629.194.camel@concordia>
Content-Type: text/plain
Date: Sat, 20 Jun 2009 08:59:10 +1000
Message-Id: <1245452350.16880.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Mitchell <dmitchell@amcc.com>, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-19 at 18:24 +1000, Michael Ellerman wrote:
> I think we /probably/ want a similar change in legacy_serial.c, for
> soc
> ports at least.
> 
> Or do people have things that are compatible "ns16550" but aren't?
> 
Do we really want to keep of_serial.c ?

I fail to see the point in keeping -both- the of_serial (of_device
variant) and the legacy serial stuff which shims the device-tree into
platform devices.

They tend to clash with each other too, which is annoying.

Cheers,
Ben

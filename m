Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01292DDE01
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:53:47 +1000 (EST)
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1208450247.9212.275.camel@pmac.infradead.org>
References: <1208105558.3026.137.camel@pmac.infradead.org>
	<4807427B.3030902@genesi-usa.com>
	<1208443057.9212.250.camel@pmac.infradead.org>
	<48076A00.1080608@genesi-usa.com>
	<1208450247.9212.275.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 19 Apr 2008 10:53:32 +1000
Message-Id: <1208566412.6958.429.camel@pasglop>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> OTOH, it probably wouldn't be _so_ hard to port Mitch's OpenFirmware to
> mpc5200...

Yup, especially since it's pretty much just a 603 core which I would
expect is already supported by firmworks stuff... 

Ben.

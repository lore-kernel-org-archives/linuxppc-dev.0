Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1290867A3E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 06:55:53 +1000 (EST)
In-Reply-To: <1145905793.4082.27.camel@enki.eridu>
References: <1143586160.2660.19.camel@enki.eridu>
	<66cc5bfb5a367a814fbace8105572658@penguinppc.org>
	<1143599612.2704.14.camel@enki.eridu>
	<1145547307.5314.118.camel@cashmere.sps.mot.com>
	<1145905793.4082.27.camel@enki.eridu>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5E473F0A-C2E2-4ABD-A9FA-E83C4B4CB6C3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] DTC - validation by device_type
Date: Mon, 24 Apr 2006 22:55:40 +0200
To: Paul Nasrat <pnasrat@redhat.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	CHECK_HAVE(net, "reg");
>>> +	CHECK_HAVE(net, "local-mac-address");
>>> +	CHECK_HAVE(net, "mac-address");
>>> +	CHECK_HAVE(net, "address-bits");

1) It's hard to see how any (physical) network device would
not have a "reg" property.  It is not required though.

2) "local-mac-address" is not a required property.

3) "mac-address" is only required for nodes that have been
opened before.

4) "address-bits" is not required (taken as 48 if absent).

Please see Annex A (look at the property names, and perhaps
at the "network" device type).  _Always_ look at Annex A!
It's normative.


Segher

Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2682DE0C9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 03:04:01 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3GH3v38016946
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 10:03:58 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n3GH3u8I004516
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 12:03:56 -0500 (CDT)
Date: Thu, 16 Apr 2009 12:03:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: OF PCI howto?
Message-ID: <20090416170355.GA20034@ld0162-tx32.am.freescale.net>
References: <OF2E7A8F65.EA7B7D26-ONC1257599.004624DB-C1257599.0046F2EB@transmode.se>
	<20090415130844.GB3301@pengutronix.de>
	<8BE09C31-40E4-41C2-A6D8-EE9C7DA0B625@kernel.crashing.org>
	<OF08A8F393.64CD0E94-ONC125759A.00276611-C125759A.002C76B2@transmode.se>
	<c8485d470904160203y66d456f7xd73692b177587822@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8485d470904160203y66d456f7xd73692b177587822@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 11:03:56AM +0200, Roderick Colenbrander wrote:
> The ipic driver code and various dts files are evil and store the
> linux kernel value inside the DTS file, so they don't do any
> conversion whis is EVIL
> in my opinion. Watch out for that. (The corresponding DTS files and
> drivers should be updated).

We should have made up some *other* arbitrary encoding instead?

Or perhaps reused the MPIC's screwy encoding that doesn't separate bits
for level and sense?

-Scott

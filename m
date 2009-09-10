Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 17B05B6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 08:27:06 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1376DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 08:27:04 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8AMR2GI003819
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 15:27:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8AMR1CR014223
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 17:27:01 -0500 (CDT)
Message-ID: <4AA97D50.40209@freescale.com>
Date: Thu, 10 Sep 2009 17:27:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: MPC85xx External/Internal Interrupts
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
	<d970ff420909041228h3638e840r34c0c0e79f178e55@mail.gmail.com>
	<d970ff420909041229hb3aa96dya329e06ea56dd1ac@mail.gmail.com>
	<20090906110641.GA11350@Chamillionaire.breakpoint.cc>
	<20090909182857.GB8215@b07421-ec1.am.freescale.net>
	<20090910131544.GB23433@Chamillionaire.breakpoint.cc>
	<20090910222400.GB26587@Chamillionaire.breakpoint.cc>
In-Reply-To: <20090910222400.GB26587@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Alemao <xcarandiru@gmail.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sebastian Andrzej Siewior wrote:
> So the split is a FSL thing.
> What do you thing about making this clear? Adding into every .dts a
> comment right on top or maybe in
> Documentation/powerpc/dts-bindings/fsl/?

Add an fsl/mpic.txt binding that describes this and any other 
pecularities above and beyond the base openpic binding.

-Scott

Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 781EBB7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 06:49:03 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03BEEDDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 06:49:02 +1000 (EST)
Message-ID: <4A8087D8.9040607@freescale.com>
Date: Mon, 10 Aug 2009 15:49:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: 5121 cache handling.
References: <1249649632.4940.38.camel@localhost>	
	<20090807195600.GB11681@b07421-ec1.am.freescale.net>	
	<1249935384.7077.35.camel@localhost>
	<4A808268.6000107@freescale.com>
	<1249937153.7077.38.camel@localhost>
In-Reply-To: <1249937153.7077.38.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kenneth Johansson wrote:
> Yes the memory system would obviously get a higher load but do the CPU
> actually see that? do it stall on the write ? 

Yes, there's a limited number of writes that can queue up before the CPU 
core will have to wait.

-Scott

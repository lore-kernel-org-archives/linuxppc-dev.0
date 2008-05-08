Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24711DE28E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 May 2008 01:33:21 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m48FXGi1021182
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 May 2008 08:33:16 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m48FXFjI016130
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 May 2008 10:33:15 -0500 (CDT)
Date: Thu, 8 May 2008 10:33:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sanal Kumar V K <sanalvk@centillium.com>
Subject: Re: Running a section of code from internal memory
Message-ID: <20080508153315.GC18740@ld0162-tx32.am.freescale.net>
References: <4822E5CE.3090701@centillium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4822E5CE.3090701@centillium.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, May 08, 2008 at 05:06:46PM +0530, Sanal Kumar V K wrote:
> A small part of the code needs to run from the on-chip "L2 scratch" for
> getting optimum performance. I would really appreciate if some could
> give me some pointers regarding the following questions:
> 
> 1. Is #pragma section supported by gcc.
> The compiler prints this warning "ignoring #pragma section" and the
> pragma is ignored indicating that it is not supported. Is there any way
> I can get the pragma working for gcc or any alternative?

__attribute__((section("section name")))

-Scott

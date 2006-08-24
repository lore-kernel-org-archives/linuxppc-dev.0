Return-Path: <segher@kernel.crashing.org>
Received: from mail.arcor.de (mail-in-05.arcor-online.net [151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F06167B7E
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 01:54:10 +1000 (EST)
In-Reply-To: <17645.18647.720814.903612@cargo.ozlabs.ibm.com>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
	<200608192219.03178.arnd@arndb.de>
	<37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
	<1156190965.9659.41.camel@farscape.rchland.ibm.com>
	<17645.18647.720814.903612@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9FF8F72E-5990-4AED-A826-9E1C9C889DB6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
Date: Thu, 24 Aug 2006 17:53:56 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de, segher@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Also it would be really nice if you could figure out a way to
> avoid doing the unnecessary 64-bit logical operations on 32-bit
> machines

Like I asked before -- should we run this emulation on 32-bit
machines at all?  The instruction only exists in the 64-bit
architecture after all.


Segher

Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FE2ADDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 07:22:51 +1000 (EST)
Message-ID: <464CC5D7.1010700@freescale.com>
Date: Thu, 17 May 2007 16:15:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<8183195dad79296e3986f561bf929067@kernel.crashing.org>
	<464CADBB.9050500@freescale.com>
	<1e7cedebed6b67737c68fa01d832c3f3@kernel.crashing.org>
In-Reply-To: <1e7cedebed6b67737c68fa01d832c3f3@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> How is it incorrect?
> 
> 
> You specified that an interrupt specifier consists of two
> cells.  This is wrong.

Oops...  Apparently, that was copied from other bindings with the same 
problem.

Next time I'll look more carefully at a patch from 6 months ago before 
resending it. :-P

-Scott

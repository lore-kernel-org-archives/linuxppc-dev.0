Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 0D0D367B96
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 06:13:32 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k6JLV8rf016705
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 15:31:08 -0600 (MDT)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6JKDTXl015935
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 15:13:30 -0500 (CDT)
Message-ID: <44BE9268.9040806@freescale.com>
Date: Wed, 19 Jul 2006 15:13:28 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
References: <44B7857A.2060101@freescale.com>	<B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>	<a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>	<A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
	<1153166894.4459.4.camel@basalt.austin.ibm.com>
In-Reply-To: <1153166894.4459.4.camel@basalt.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:

> Seems to me that it's far better to have init code in the kernel than
> firmware. For one example, look at the x86 video card init problem
> PowerPC Linux has. It's also far easier to fix/deploy Linux code than
> firmware code, as Li observed, and on top of that it's less work for
> non-UBoot firmwares in the future.

I also agree 100%.  The boot loader should only be required to initialize whatever hardware it uses.  The kernel should be required to initialize whatever hardware it supports.  The kernel should not assume that USB or PCI or whatever has already been initialized by the boot loader.  This doesn't happen on x86, so we should it happen on PPC?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

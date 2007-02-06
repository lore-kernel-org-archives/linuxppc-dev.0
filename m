Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 302A9DDE35
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 10:42:49 +1100 (EST)
Message-ID: <45C91275.4020806@freescale.com>
Date: Tue, 06 Feb 2007 17:42:45 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
References: <11707051151024-git-send-email-timur@freescale.com>	
	<20070206013051.GA15525@lixom.net>
	<45C90A6E.3040302@freescale.com>	
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
In-Reply-To: <1170805102.2620.264.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> It would have been for the 2-line display on IBM RS/6000 machines.  If
>> that's still needed, we can put it in arch/powerpc/platforms/chrp
>> somewhere, so feel free to remove it from ppc_init().
> 
> Do we actually care about this progress stuff ? 

I think support for LED progress displays is a nice feature to have.

The only reason I noticed it is because on Freescale boards, it's the only way 
to get printk-like functionality early in the boot process.

> I've been tempted more
> than once to rip it all off... we have console access as early as we can
> do progress output on most powerpc platforms nowadays.

Is that what udbg_progress() uses?  I'm not really familiar with the early 
console stuff.

> If we really want some way of ack'ing that the kernel reached known
> known steps with something different than a printk-type interface, then
> we should probably have somewhere a list of well defined numeric
> constants and use those, but then, I don't like magic numbers.

Me neither.  I think on systems like RS6000, the progress codes have already 
been defined, so I don't think we can redefine them.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

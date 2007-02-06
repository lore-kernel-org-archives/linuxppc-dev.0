Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 675EBDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 10:42:25 +1100 (EST)
In-Reply-To: <1170805102.2620.264.camel@localhost.localdomain>
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net> <45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0C529499-B766-4D3A-8340-361BB1B461D3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
Date: Tue, 6 Feb 2007 17:41:24 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 5:38 PM, Benjamin Herrenschmidt wrote:

>
>> It would have been for the 2-line display on IBM RS/6000  
>> machines.  If
>> that's still needed, we can put it in arch/powerpc/platforms/chrp
>> somewhere, so feel free to remove it from ppc_init().
>
> Do we actually care about this progress stuff ? I've been tempted more
> than once to rip it all off... we have console access as early as  
> we can
> do progress output on most powerpc platforms nowadays.
>
> If we really want some way of ack'ing that the kernel reached known
> known steps with something different than a printk-type interface,  
> then
> we should probably have somewhere a list of well defined numeric
> constants and use those, but then, I don't like magic numbers.

I'm with Ben on this.  I'm not aware of any in tree user that just  
doesn't print this stuff out to a console port.  The concept is nice,  
but does anyone really use it?

I know I end up using a JTAG and dumping the memory at logbuf before  
using an LED to figure out where I'm at.

- k

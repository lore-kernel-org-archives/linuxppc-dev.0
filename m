Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 077AEDDE48
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 09:08:03 +1100 (EST)
Message-ID: <45CA4DBC.7090401@freescale.com>
Date: Wed, 07 Feb 2007 16:07:56 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mac-address vs. local-mac-address
References: <45CA41F7.6020700@freescale.com>
	<1170883956.2620.305.camel@localhost.localdomain>
	<45CA47AB.1000302@freescale.com>
	<0EF1DDFB-E590-422C-8FA6-0FD643E68F49@kernel.crashing.org>
In-Reply-To: <0EF1DDFB-E590-422C-8FA6-0FD643E68F49@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> The problem with u-boot is that the correct way would be to use 
> local-mac-address for what's compiled into u-boot and mac-address if 
> someone does a 'setenv' to modify the mac address.  The question is 
> anyone really going to care that much.

I don't think the compiled-in MAC address should be used at all.

For most boards, the compiled-in option is just some random MAC address.  When 
the board is shipped, the manufacturer creates his own set of environment 
variables and overrides what's stored on flash.

I actually think that storing a MAC address in a board configuration for or a 
DTS is a bad idea, because MAC addresses are supposed to be unique for each 
Ethernet device, and storing a fixed value in a source file breaks that. 
However, that's a separate issue.  I was just trying to stress that the 
compiled-in MAC address is of no value.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

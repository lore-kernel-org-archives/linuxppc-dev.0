Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 2F3D8DDE3A
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 07:18:45 +1100 (EST)
Message-ID: <45CCD721.8@freescale.com>
Date: Fri, 09 Feb 2007 14:18:41 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add support for MPC8349E-mITX-GP
References: <11710512363897-git-send-email-timur@freescale.com>
	<317DF39B-8D20-431A-80D1-74CAE643B241@kernel.crashing.org>
In-Reply-To: <317DF39B-8D20-431A-80D1-74CAE643B241@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>> USB is disabled because the only active USB port currently is not 
>> supported
>> in the kernel.
> 
> What is not supported?  We support both MPH and DR on 834x?

It just doesn't work.  I think Leo's patches for the 8349 EMDS are the missing 
piece, but they need to be adapted to the ITX and ITX-GP.

Unfortunately, I don't know enough about USB to know what exactly Leo's patch is 
addressing, or why the USB port on the ITX-GP doesn't.  And I don't have the 
time to fix everything at once.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id EE840679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 04:51:20 +1000 (EST)
In-Reply-To: <026801c661ed$bcb352d0$0760120a@photon>
References: <026801c661ed$bcb352d0$0760120a@photon>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <35CCBAB0-7BA0-4CA0-879D-F6D90ACD3AC2@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: about ppc <asm/string.h>
Date: Mon, 17 Apr 2006 13:52:43 -0500
To: HappyPhot <happyphot@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

There's no string.h in include/asm-ppc because this is one of the  
header files that has been merged between 32 and 64-bit powerpc.  It  
now lives in include/asm-powerpc with all the other merged headers.  
Only headers specific to 32-bit ppc have been left in include/asm- 
ppc.  For a kernel build with ARCH=ppc, the build uses headers from  
both include/asm-ppc and include/asm-powerpc.  This is accomplished  
through the use of a temporary include directory that is created in  
the arch dir.  Check out arch/ppc/Makefile for details.

Cheers,
-Becky

On Apr 17, 2006, at 2:08 AM, HappyPhot wrote:

> Hi,
>
>   Under linux kernel, the file /include/linux/string.h will include
> <asm/string.h>.
>   But I didn't found "string.h" under "asm-ppc", my asm is link to  
> asm-ppc
> (CPU is ppc). This makes me compile some code failed.
>   (kernel version 2.6.x)
>
>   Anybody knows about this ? Why there is no string.h under "asm-ppc"
> directory.
>
> thanks a lot,
> /Phot
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

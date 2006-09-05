Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1EDF967B62
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 08:30:15 +1000 (EST)
In-Reply-To: <198592450609051522i572697f8nb252ea58e7f60ae@mail.gmail.com>
References: <198592450609051522i572697f8nb252ea58e7f60ae@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <73C484E7-4A6A-4B13-8F96-0FEC71E0F5B4@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: where can I find MPC8245 assembler reference?
Date: Tue, 5 Sep 2006 17:30:16 -0500
To: Reeve Yang <yang.reeve@gmail.com>
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

MPC8245 refers to the integrated product (core + peripherals, all on  
one chip).  The MPC8245 has a powerpc 603e core (also known as the  
G2).  That's a classic 32-bit powerpc, so the assembler reference you  
want is:

http://www.freescale.com/files/product/doc/MPCFPE32B.pdf

Hope this helps,
Becky


On Sep 5, 2006, at 5:22 PM, Reeve Yang wrote:

> Could anyone point me to online document for MPC8245 assembler  
> reference? I couldn't find it anywhere but the command list in user  
> manual. Thanks!
>
> - Reeve
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

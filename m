Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 83D6C67C25
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 23:24:57 +1000 (EST)
In-Reply-To: <20050714125232.GA13456@janus>
References: <20050714125232.GA13456@janus>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E6D8678E-33FD-492F-A773-12B0F87C2EBB@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 14 Jul 2005 08:24:55 -0500
To: "Frank van Maarseveen" <frankvm@frankvm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Using lswi/stswi inside the kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, not all PowerPC implementations actually implement this  
instructions.  Also, on a number of them there is no performance  
improvement when using the instructions.

- kumar

On Jul 14, 2005, at 7:52 AM, Frank van Maarseveen wrote:

> Are there any issues I should be aware of?
>
> I think most SAVE_GPR* and REST_GPR* macros could be replaced by a
> single lswi/stswi instruction.
>
> -- 
> Frank
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

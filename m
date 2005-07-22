Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B70C867D10
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jul 2005 07:58:58 +1000 (EST)
In-Reply-To: <17121.14182.92600.906359@home1.localdomain>
References: <17121.14182.92600.906359@home1.localdomain>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E5B7BB81-C268-448D-BCEC-6B619D81D793@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 22 Jul 2005 16:58:44 -0500
To: Yuli Barcohen <yuli@arabellasw.com>
Cc: debian-embedded@lists.debian.org, linuxppc-embedded@ozlabs.org
Subject: Re: Experiences with Debian Sarge on MPC8xx ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does that actually work or are you suggesting something to try?

- kumar

On Jul 22, 2005, at 1:13 PM, Yuli Barcohen wrote:

> Try to change cache line size to zero in arch/ppc/kernel/cputable.c
>
> --  
> ====================================================================== 
> ==
>  Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project  
> Leader
>  yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software,  
> Israel
> ====================================================================== 
> ==
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

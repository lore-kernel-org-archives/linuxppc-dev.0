Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id ECA1567E43
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 15:47:19 +1000 (EST)
In-Reply-To: <9b7ca6570508022240715ae9cb@mail.gmail.com>
References: <9b7ca6570508022240715ae9cb@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <61C27372-4ADB-4E3A-8E20-9E811EE61B99@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 3 Aug 2005 00:47:18 -0500
To: Daniel Ann <ktdann@gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8245 reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Do you have a VIA chipset on your system?  If not what sandpoint is  
doing is not going to help you much.

- kumar

On Aug 3, 2005, at 12:40 AM, Daniel Ann wrote:

> Hey folks,
>
> I have a problem with rebooting my box(its pretty much based on  
> sandpoint).
> Looking at sandpoint_restart() function, I have no idea what it's
> doing. Can somebody please help me out where I should be looking ?
> Would this be pure software problem? or just might be hardware problem
> ?
>
> Always thought rebooting was piece of cake, but.. guess not :P
> -- 
> Daniel
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

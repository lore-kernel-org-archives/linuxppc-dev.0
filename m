Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C1ACD68880
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 08:46:03 +1100 (EST)
In-Reply-To: <1134569118.3875.9.camel@localhost>
References: <1134569118.3875.9.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9892D605-1B30-4094-AEEC-9DA6F3B13B05@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Wed, 14 Dec 2005 15:46:08 -0600
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2005, at 08:05, Johannes Berg wrote:
>
> Does that mean __copy_from_user_inatomic isn't actually valid to  
> call in
> atomic context? Or is this only so that kernel developers that use
> powerpc see the bugs their code would have on other platforms? The  
> magic
> in get_user_asm thoroughly confuses me.
>
> [Somehow I got sidetracked. I only wanted to look at implementing
> backtrace support for oprofile...]


What platform is this on?  The copy from user stuff is a bit out of  
my area of expertise, but I've got an implementation of backtrace for  
oprofile running on 85xx.  Mostly, it's just a hacked up version of  
the ppc64 patch that was floating around.

Andy

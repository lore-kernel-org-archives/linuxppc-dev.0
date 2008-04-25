Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E143EDDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 13:37:23 +1000 (EST)
Message-Id: <8564AA3F-C745-4A5A-952F-477B6A68681C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <4811593B.8080508@hypersurf.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: sysfs cpu entry
Date: Thu, 24 Apr 2008 22:36:59 -0500
References: <4811593B.8080508@hypersurf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 24, 2008, at 11:08 PM, Kevin Diggs wrote:
> Hi,
>
> 	Can someone suggest where to add the code for a cpu
> (/sys/devices/system/cpu/cpu0) entry in sysfs?
>
> 	The 2.6.24 release has a sysfs.c file but it only seems to be used  
> for 64-bit? Anyone know why? What kind of planetary disasters will I  
> create if I allow it to be used in 32-bit as well?
>
> kevin

There's no huge harm just make sure that you fixup things to only  
expose registers that exist on a 32-bit part.

What 32-bit chip are you looking to enable this for?

- k

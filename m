Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9D7DDE067
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 01:44:55 +1100 (EST)
Message-Id: <D929D930-99A7-44B1-82EC-C86187B4B4B5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: willy jacobs <willy.jacobs@nl.thalesgroup.com>
In-Reply-To: <49954CA9.9040203@nl.thalesgroup.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Gianfar ethernet MPC85xx driver not seen anymore when moving to
	2.6.29 kernel
Date: Fri, 13 Feb 2009 08:44:45 -0600
References: <49954CA9.9040203@nl.thalesgroup.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2009, at 4:34 AM, willy jacobs wrote:

> When I moved (config file and device tree) from 2.6.28 (and earlier  
> kernel releases) to 2.6.29-rc2 for some reason
> the Gianfar driver is correctly compiled in, but not probed anymore  
> during kernel booting.
>
> I looked into the Changelogs, but did'nt see any change regarding  
> this.
>
> Do I need to change the device tree and/ir config file?
> -- 
> willy
> Unclassified

Can you try -rc4.  There are a number of bug fixes that have gone in.   
Also have you made updates to your .dts per:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4

- k

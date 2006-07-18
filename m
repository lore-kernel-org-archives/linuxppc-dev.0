Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D12E67B80
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:52:20 +1000 (EST)
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0509EB@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D0509EB@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <41AD230F-91E8-442A-B9F9-9892D14BEF12@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Tue, 18 Jul 2006 08:52:31 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]

>> Well, I think there is a coupling that exists between whatever your
>> boot rom is and the kernel.  If you are trying to optimize boot time
>> I'd say one thing you would want is to avoid multiple writing the
>> same configuration registers.
>>
>> I dont have an issue if a fixed function board decides to do these
>> things in their kernel init instead of their boot rom.  I however,
>> don't want thousand and one config options to support all the various
>> ways one can configure the Freescale board.
>
> We won't have the thousand and one config options, making use of the
> device
> tree.  So this is not a problem.

I'm talking about opening the door to a ton of options, not that we  
have them now.  For example, your patch doesnt handle the USB PHYs if  
they are on the MDS instead of the SYS board.  It doesn't handle  
setting SCCR properly for different frequency choices.  I'm concerned  
about where to draw the line because of all the ways a user can  
configure the MDS board.

- kumar

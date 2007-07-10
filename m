Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86683DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 23:13:20 +1000 (EST)
Message-ID: <4693861F.2000403@genesi-usa.com>
Date: Tue, 10 Jul 2007 14:14:07 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ThomasB <psyphi@gmail.com>
Subject: Re: [kernel-2.6.19]Marvell GT-64260 and Ethernet
References: <13b81f0c0707092336r5c7f4996u6f9c73d95c63bdc6@mail.gmail.com>
In-Reply-To: <13b81f0c0707092336r5c7f4996u6f9c73d95c63bdc6@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Isn't the ethernet the same on the 64260, 64360, 64460?

There's definitely a driver for 6436x and above..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

ThomasB wrote:
> Hi all,
> I'm porting a Linux kernel 2.6.19 on a PowerPC 750 FX board.
> My Linux runs completely except for Ethernet. I don't find any Ethernet
> driver for my bridge. Do you know if there is an Ethernet driver for the
> Marvell GT-64260 bridge for PowerPC processor. I found a GT-64260
> ethernet driver in the kernel 2.4.34 for MIPS processor, will it be
> possible to port it in a 2.6 kernel?
> Thanks for you help.
> 
> 
> -- 
> ThomasB
> http://psyphi.zeblog.com/ <http://psyphi.zeblog.com/>
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

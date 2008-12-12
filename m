Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CC09DE06B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 11:19:29 +1100 (EST)
Message-Id: <EE58AED7-C014-4009-ADB8-F8D5AC0B6221@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ron Madrid <ron_madrid@sbcglobal.net>
In-Reply-To: <683138.71397.qm@web83507.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Problem building kernel
Date: Thu, 11 Dec 2008 18:19:20 -0600
References: <683138.71397.qm@web83507.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 11, 2008, at 5:48 PM, Ron Madrid wrote:

> Hello all,
>
> I got the latest kernel from git://git.denx.de/linux-2.6-denx.git  
> and after
> configuring with menuconfig I am seeing these errors.  I feel like  
> this
> could be something simple that I am just unaware of, but I'm not sure
> and haven't been able to find anything useful when doing a web search.
>
> Any ideas?  What other information would be helpful?
>
>  BOOTCC  arch/powerpc/boot/redboot-83xx.o
>  BOOTCC  arch/powerpc/boot/cuboot-sam440ep.o
>  BOOTCC  arch/powerpc/boot/cuboot-acadia.o
> {standard input}: Assembler messages:
> {standard input}:278: Error: Unrecognized opcode: `mtdcr'
> {standard input}:282: Error: Unrecognized opcode: `mfdcr'
> {standard input}:289: Error: Unrecognized opcode: `mtdcr'
> {standard input}:293: Error: Unrecognized opcode: `mfdcr'
> {standard input}:312: Error: Unrecognized opcode: `mtdcr'
> {standard input}:316: Error: Unrecognized opcode: `mfdcr'
> make[2]: *** [arch/powerpc/boot/cuboot-acadia.o] Error 1
> make[1]: *** [zImage] Error 2
> make: *** [sub-make] Error 2
>
> Ron

I swear Josh or Grant fixed this.

- k

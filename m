Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C200DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 01:27:14 +1000 (EST)
In-Reply-To: <18121.11392.459659.535657@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181206070.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181207530.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181210390.31362@blarg.am.freescale.net>
	<18121.11392.459659.535657@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B29E93AE-520F-403B-BB20-CD847E575B9D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3 v2][POWERPC] Stop include asm-ppc when building
	ARCH=powerpc for ppc32
Date: Mon, 20 Aug 2007 10:28:55 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 20, 2007, at 12:54 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> We no longer have any dependancies on include/asm-ppc so we can  
>> get ride
>> of the makefile hacks to include it in the build process.
>
> On 32-bit powermac, I get:
>
>   CC [M]  drivers/macintosh/ans-lcd.o
> /home/paulus/kernel/powerpc/drivers/macintosh/ans-lcd.c:17:25:  
> error: asm/ans-lcd.h: No such file or directory
>
> plus a whole pile of things undefined after that.
>

Fixed now.

- k

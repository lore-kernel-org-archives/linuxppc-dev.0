Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5380B7CA6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 19:21:58 +1100 (EST)
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Csdncannon <csdncannon@gmail.com>
In-Reply-To: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Mar 2010 19:21:41 +1100
Message-ID: <1269505301.8599.238.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-03-25 at 10:41 +0800, Csdncannon wrote:
>          In my program, the value of the 64-bit time base register is
> read out, and you will find the later value is even smaller than the
> earlier value from the log “log_timebase”. While the kernel depends on
> the accuracy of the timebase for the compensation of the lost PIT
> interrupt, the negative value between two continual timebase reading
> will bring to the jump of the jiffies. And this timebase problem will
> bring to the instability of the gettimeofday system call.
> 
>          Do you have any idea about this problem, thanks for your any
> advice. Attached is the code and log.

This is a concern, it should definitely not happen. What machine is
that ? is the code compiled 32-bit or 64-bit ? What kernel version ?

Arnd, any chance that could relate to the bug you've been chasing on
Cell ?

Cheers,
Ben.

> 
> Thanks
> 
> Gino
> 
> 
> 
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

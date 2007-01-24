Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24E81DDF84
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 10:39:25 +1100 (EST)
In-Reply-To: <20070124210704.GC10527@ld0162-tx32.am.freescale.net>
References: <20070124210704.GC10527@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <52B7EC8B-85EB-408C-97B7-806F8822B7A3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 03/18] Set -msoft-float and assembler target options in
	the bootwrapper.
Date: Wed, 24 Jan 2007 22:31:06 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Without -msoft-float, floating point state saving code can be executed
> (at least with certain buggy versions of GCC, which don't clear bit  
> 6 of
> CR before calling a varargs function with no varargs parameters).

I have a hard time understanding what this means.  Can you
elaborate please?

>  AFLAGS += $(cpu-as-y)
>  CFLAGS += $(cpu-as-y)
> +export cpu-as-y

Maybe it would be better to export CFLAGS instead (on the
other hand, you might have to cut out some options from it
for 32-bit compiles, dunno).


Segher

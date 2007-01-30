Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B358BDDFC7
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:43:06 +1100 (EST)
In-Reply-To: <20070129201154.GB13485@ld0162-tx32.am.freescale.net>
References: <20070129201154.GB13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <391BF096-51F2-48B8-9BE2-D49F6B61B0E5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 02/18] bootwrapper: Set -msoft-float and assembler target
	options.
Date: Tue, 30 Jan 2007 20:42:42 +0100
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

Even: without -msoft-float, GCC is allowed to use any
floating-point resources it wants (whether you like that
or not, and/or think it is a bug in GCC, is moot).

> Without the assembler target option, the assembler will use the old
> dedicated mftb/mftbu instructions, rather than mfspr.  This causes the
> boot to hang on e500, which doesn't have the dedicated instructions.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

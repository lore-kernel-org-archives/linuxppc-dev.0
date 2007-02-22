Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13D43DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 21:31:58 +1100 (EST)
In-Reply-To: <Pine.LNX.4.62.0702221112010.22848@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0702221112010.22848@pademelon.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dcd4ed49af66f0fb9bb0eb1e86823c54@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: platform_ops.malloc() vs. realloc()
Date: Thu, 22 Feb 2007 11:31:49 +0100
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> |         void *  (*malloc)(u32 size);

> |         void *  (*realloc)(void *ptr, unsigned long size);

> Is there a specific reason why the size parameters of malloc() and 
> realloc()
> differ in type?

There are good arguments to prefer either u32 or unsigned
long, so maybe the current situation is a compromise ;-P


Segher

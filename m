Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9D80CDDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 22:39:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "David Mitchell" <dmitchell@amcc.com>
Subject: Re: of_serial.c: adding UPF_FIXED_TYPE flag
Date: Thu, 4 Jun 2009 13:39:21 +0100
References: <AC5E1C3367E37D44970B81A6ADD1DA2C0772AF40@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C0772AF40@SDCEXCHANGE01.ad.amcc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906041339.22603.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 03 June 2009, David Mitchell wrote:
> Hello,
> 
> Are there any objections or concerns on adding UPF_FIXED_TYPE to the
> port flags for the of_serial driver? Or maybe - are there any
> implementations using of_serial that rely on the 8250's probing to
> determine type? Based on the configs it looks like just the 4xx and 6xx
> variants are using this driver.

We also use the driver on ppc64/cell, which is what it was initially written for.
Passing UPF_FIXED_TYPE sounds ok to me. Can you send a patch?

	Arnd <><
